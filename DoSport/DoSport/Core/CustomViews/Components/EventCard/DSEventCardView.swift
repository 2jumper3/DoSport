//
//  DSEventCardView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/02/2021.
//

import UIKit

final class DSEventCardView: UIView {
    
    struct ViewData {
        
    }
    
    private(set) lazy var headerView = CollectionViewEventCardCellHeaderView()
    private(set) lazy var bodyView = CollectionViewEventCardCellBodyView()
    private(set) lazy var footerView = CollectionViewEventCardCellFooterView()
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.mainBlue
        layer.cornerRadius = 12
        
        addSubviews(
            headerView,
            bodyView,
            footerView
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(14)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(snp.height).multipliedBy(0.164)
        }
        
        bodyView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(14)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(snp.height).multipliedBy(0.43)
        }
        
        footerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottom).offset(-8)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(snp.height).multipliedBy(0.11)
        }
    }
}

//MARK: Public API

extension DSEventCardView {
    
}

