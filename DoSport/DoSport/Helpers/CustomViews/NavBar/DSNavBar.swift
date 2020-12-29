//
//  DSNavBar.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit
import SnapKit

final class DSNavBar: UIView {
    
    enum State {
        case active, notActive
    }
    
    var state: State = .notActive {
        didSet {
            setState()
        }
    }
    
    var title: String? {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue}
    }
    
    var searchBarDelegate: Any? = nil {
        didSet {
            
        }
    }
    
    private let titleLabel: UILabel = { // ToDo: Make text bold 500
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = Colors.mainBlue
        $0.textAlignment = .center
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private lazy var searchBar = DSSearchBar()
    
    override internal var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(titleLabel, searchBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        titleLabel.snp.makeConstraints {
            $0.height.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-5)
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        
        searchBar.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(searchBar.snp.height)
        }
    }
}

//MARK: - Public methods
extension DSNavBar {
    func bind(state: State) {
        self.state = state
    }
}

//MARK: - Private Methods
private extension DSNavBar {
    func setState() {
        switch self.state {
        case .active:
            print(state)
        case .notActive:
            print(state)
        }
    }
}

