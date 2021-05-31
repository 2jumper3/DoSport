//
//  SportGroundDetailDataSource.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import UIKit


protocol SportGroundDetailDataSourceDelegate: class {
    func collectionViewNeedsReloadData()
    func collectionDidClickSubscribers()
    func collectionDidClickSubscriptions()
    func collectionDidClickOptions(for event: Event?)
}

final class SportGroundDetailDataSource: NSObject {
    
    var userMainDataSourceState: DSEnums.UserMainContentType = .events {
        didSet {
            delegate?.collectionViewNeedsReloadData()
        }
    }
    
    weak var delegate: SportGroundDetailDataSourceDelegate?
    
    var events: [DSModels.Event.EventView]?
    var sportGrounds: [DSModels.SportGround.SportGroundResponse]?

    private var toogleSegmentedControl: DSSegmentedControl?
    
    init(viewModels: [DSModels.Event.EventView]? = []) {
        self.events = viewModels
        super.init()

    }
}

//MARK: - UICollectionViewDataSource -

extension SportGroundDetailDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            switch userMainDataSourceState {
            case .events: return 10
            case .sportGrounds: return 15
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: UICollectionViewCell
//        let event = events?[indexPath.row]
        
        if indexPath.section == 0 {
            let userInfoCell: UserMainInfoCollectionCell = collectionView.cell(forRowAt: indexPath)
            userInfoCell.onSubscribersButtonClicked = { [unowned self] in
                delegate?.collectionDidClickSubscribers()
            }

            userInfoCell.onSubscribesButtonClicked = { [unowned self] in
                delegate?.collectionDidClickSubscriptions()
            }

            cell = userInfoCell
            
        } else {
            switch userMainDataSourceState {
            case .events:
                let eventCell: EventCardCollectioCell = collectionView.cell(forRowAt: indexPath)
                eventCell.onOptionButtonClicked = { [unowned self] in
                    delegate?.collectionDidClickOptions(for: nil)
                }
                
                cell = eventCell
                
            case .sportGrounds:
                let sportGroundCell: SportGroundSelectionCollectionCell = collectionView.cell(forRowAt: indexPath)
                cell = sportGroundCell
            }
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let reusableView: CustomSegmentView3segment = collectionView.dequeReusabeView(
                of: kind,
                at: indexPath
            )
            reusableView.setSegmentedControl(text: Texts.UserMain.myEvents, for: 0)
            reusableView.setSegmentedControl(text: Texts.UserMain.mySportGrounds, for: 1)
            
            reusableView.onSegmentedControlChanged = { [unowned self] index in
                switch index {
                case 0: userMainDataSourceState = .events
                case 1: userMainDataSourceState = .sportGrounds
                default: break
                }
            }
            return reusableView
        }
        
        return UICollectionReusableView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension SportGroundDetailDataSource: UICollectionViewDelegateFlowLayout  {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var sectionZeroCellHeight: CGFloat = collectionView.bounds.height
        var eventsCellsHeight: CGFloat = collectionView.bounds.height
        var sportGroundsCellsHeight: CGFloat = collectionView.frame.height

        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            sectionZeroCellHeight *= 0.24
            sportGroundsCellsHeight *= 0.19
            eventsCellsHeight *= 0.37
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            sectionZeroCellHeight *= 0.21
            sportGroundsCellsHeight *= 0.17
            eventsCellsHeight *= 0.35
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            sectionZeroCellHeight *= 0.19
            sportGroundsCellsHeight *= 0.15
            eventsCellsHeight *= 0.32
        }

        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: sectionZeroCellHeight)
        } else {
            switch userMainDataSourceState {
            case .events: return CGSize(width: collectionView.bounds.width, height: eventsCellsHeight)
            case .sportGrounds: return CGSize(width: collectionView.bounds.width, height: sportGroundsCellsHeight)
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 1 {
            let height: CGFloat
            
            switch UIDevice.deviceSize {  // FIXME: костыль?
            case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = 50
            case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = 53
            case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = 55
            }
            
            return CGSize(width: collectionView.bounds.width, height: height)
        }
        
        return CGSize()
    }
}
