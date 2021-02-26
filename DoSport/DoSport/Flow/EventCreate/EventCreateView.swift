//
//  EventCreateView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

protocol EventCreateViewDelegate: class {
    func createButtonClicked()
}

final class EventCreateView: UIView {
    
    weak var delegate: EventCreateViewDelegate?
    
    // MARK: Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.registerClass(TextViewCell.self)
        tableView.registerClass(EventTypeCell.self)
        tableView.registerClass(SelectionCell.self)
        tableView.registerClass(MembersCountCell.self)
        tableView.registerHeaderFooter(EventTypeTableCellFooter.self)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = Colors.dirtyBlue
        tableView.backgroundColor = Colors.darkBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var createButton = CommonButton(title: Texts.EventCreate.create, state: .disabled)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        createButton.addTarget(self, action: #selector(handleCreateButton))
        
        addSubviews(tableView, createButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var buttonsHeight: CGFloat = 48
        var buttonBottom: CGFloat = 15
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            buttonsHeight = 46
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            buttonsHeight = 48
            buttonBottom += 15
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            buttonsHeight = 49
            buttonBottom += 20
        default: break
        }
        
        tableView.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(safeAreaInsets.top).offset(2)
            $0.bottom.equalTo(createButton.snp.top).offset(createButton.frame.height/2)
        }
        
        createButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.89)
            $0.height.equalTo(buttonsHeight)
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-buttonBottom)
        }
    }
}

//MARK: Public API

extension EventCreateView {
    
    func updateTableDataSource(dataSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
        layoutIfNeeded()
    }
    
    func bindCreateButton(state: CommonButtonState) {
        createButton.bind(state: state)
    }
}

//MARK: Actions

@objc private extension EventCreateView {
    
    func handleCreateButton() {
        delegate?.createButtonClicked()
    }
}


