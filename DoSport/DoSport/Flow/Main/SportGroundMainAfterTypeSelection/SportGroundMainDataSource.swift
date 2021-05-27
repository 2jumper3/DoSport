//
//  SportGroundMainDataSource.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//



import UIKit

protocol SportGroundMainDataSourceDelegate: class {
    func collectionView(didSelect sportGround: SportGround)
    func collectionViewNeedsReloadData()
}

final class SportGroundMainDataSource: NSObject {
    
    weak var delegate: SportGroundMainDataSourceDelegate?
    
    var viewModels: [SportGround]
    var events: [DSModels.Event.EventView]?
    var sportGrounds: [DSModels.SportGround.SportGroundResponse]?
    
    private var selectedCell: SportTypeListTableCell?
    
    var sportGroundSourceState: DSEnums.UserMainContentType = .events {
        didSet {
            delegate?.collectionViewNeedsReloadData()
        }
    }
    
    init(viewModels: [SportGround] = []) {

        self.viewModels = viewModels
        super.init()
        
    }
}

//MARK: - UICollectionViewDataSource -

extension SportGroundMainDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sportGroundSourceState {
        case .events: return 10
        case .sportGrounds: return 10
         }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch sportGroundSourceState {
        case .events:
            let eventCell: EventCardCollectioCell = collectionView.cell(forRowAt: indexPath)
            cell = eventCell

        case .sportGrounds:
            let sportGroundCell: SportGroundSelectionCollectionCell = collectionView.cell(forRowAt: indexPath)
            cell = sportGroundCell
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate -

extension SportGroundMainDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        delegate?.collectionView(didSelect: viewModel)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let reusableView: ReusableCollectionSegmentedView = collectionView.dequeReusabeView(
                of: kind,
                at: indexPath
            )
            reusableView.setSegmentedControl(text: Texts.UserMain.myEvents, for: 0)
            reusableView.setSegmentedControl(text: Texts.UserMain.mySportGrounds, for: 1)

            reusableView.onSegmentedControlChanged = { [unowned self] index in
                switch index {
                case 0: sportGroundSourceState = .events
                case 1: sportGroundSourceState = .sportGrounds
                default: break
                }
            }
            return reusableView
        }

        return UICollectionReusableView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension SportGroundMainDataSource: UICollectionViewDelegateFlowLayout  {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var eventsCellsHeight: CGFloat = collectionView.bounds.height
        var sportGroundsCellsHeight: CGFloat = collectionView.frame.height

        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            sportGroundsCellsHeight *= 0.19
            eventsCellsHeight *= 0.37
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            sportGroundsCellsHeight *= 0.17
            eventsCellsHeight *= 0.35
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            sportGroundsCellsHeight *= 0.15
            eventsCellsHeight *= 0.32
        }

            switch sportGroundSourceState {
            case .events: return CGSize(width: collectionView.bounds.width, height: eventsCellsHeight)
            case .sportGrounds: return CGSize(width: collectionView.bounds.width, height: sportGroundsCellsHeight)
            }
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0 {
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

