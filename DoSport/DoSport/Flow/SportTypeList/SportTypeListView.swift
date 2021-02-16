//
//  SportTypeListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

protocol SportTypeListViewDelegate: class {
    func selectButtonClicked()
}

final class SportTypeListView: UIView {
    
    weak var delegate: SportTypeListViewDelegate?
    
    //MARK: Outlets
    
    private let topSeparatorView = DSSeparatorView()

    private lazy var tableView: UITableView = {
        $0.registerClass(TableViewSportTypeListCell.self)
        $0.separatorColor = Colors.dirtyBlue
        $0.backgroundColor = Colors.darkBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    private lazy var selectButton = CommonButton(title: Texts.SportTypeList.select, state: .disabled)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        selectButton.addTarget(self, action: #selector(handleSelectButton))
        
        addSubviews(topSeparatorView, selectButton, tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topSeparatorView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(1)
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(topSeparatorView.snp.bottom).offset(1)
            $0.bottom.equalTo(selectButton.snp.top).offset(-5)
        }
        
        [topSeparatorView, tableView].forEach { $0.snp.makeConstraints { $0.centerX.width.equalToSuperview() } }
        
        selectButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-50) // FIXME: !
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Public API

extension SportTypeListView {
    
    func udpateTableDataSource(dataSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
        layoutIfNeeded()
    }
    
    func bindSelectButton(state: CommonButtonState) {
        selectButton.bind(state: state)
    }
}

//MARK: Actions

@objc private extension SportTypeListView {
    
    func handleSelectButton() {
        delegate?.selectButtonClicked()
    }
}


