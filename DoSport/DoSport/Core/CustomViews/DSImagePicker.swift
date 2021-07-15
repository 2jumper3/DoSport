//
//  DSImagePicker.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/01/2021.
//

import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate: class {
    func imagePicker(_ imagePicker: DSImagePicker, didSelect image: UIImage)
    func cancelButtonDidClick(on imageView: DSImagePicker)
    func imagePicker(
        _ imagePicker: DSImagePicker,
        grantedAccess: Bool,
        to sourceType: UIImagePickerController.SourceType
    )
}

/// This class describes object that manages all image pickings functionality from device gallery
///
/// Object of this class is used by `VC` to:
/// 1) show to user access alert to enable app read from device gallety;
/// 2) get photo from user's device gallery;
final class DSImagePicker: NSObject {

    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil

    /// Closes and dismissed user's gallery application
    func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }
    
    /// Opens and presents user's gallery application in modal screen(not fullscreen)
    func present(
        parent viewController: UIViewController,
        sourceType: UIImagePickerController.SourceType
    ) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        controller.allowsEditing = true
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: - Get access to camera or photo library -

extension DSImagePicker {
    
    private func showAlert(targetName: String, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let alertVC = UIAlertController(
                title: "Access to the \(targetName)",
                message: "Please provide access to your \(targetName)",
                preferredStyle: .alert
            )
            
            alertVC.addAction(
                UIAlertAction(
                    title: "Settings",
                    style: .default,
                    handler: { action in
                        guard
                            let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                            UIApplication.shared.canOpenURL(settingsUrl)
                        else {
                            completion?(false);
                            return
                        }
                        
                        UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                            self?.showAlert(targetName: targetName, completion: completion)
                        }
            }))
            
            alertVC.addAction(
                UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                    completion?(false)
                }))
            
            UIApplication.shared.windows.filter { $0.isKeyWindow }
                .first?
                .rootViewController?
                .present(alertVC, animated: true, completion: nil)
        }
    }

    func cameraAsscessRequest() {
        if delegate == nil {
            return
        }
        
        let source = UIImagePickerController.SourceType.camera
        
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            delegate?.imagePicker(self, grantedAccess: true, to: source)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                
                if granted {
                    self.delegate?.imagePicker(self, grantedAccess: granted, to: source)
                } else {
                    self.showAlert(targetName: "camera") {
                        self.delegate?.imagePicker(self, grantedAccess: $0, to: source)
                    }
                }
            }
        }
    }

    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            
            let source = UIImagePickerController.SourceType.photoLibrary
            
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                }
            } else {
                self.showAlert(targetName: "photo gallery") {
                    self.delegate?.imagePicker(self, grantedAccess: $0, to: source)
                }
            }
        }
    }
}

// MARK: - UINavigationControllerDelegate -

extension DSImagePicker: UINavigationControllerDelegate { }

// MARK: - UIImagePickerControllerDelegate -

extension DSImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            return
        }

        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
        } else {
            print("Other source")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
