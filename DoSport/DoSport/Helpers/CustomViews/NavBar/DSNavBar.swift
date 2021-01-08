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
    
    var onSearchButtonDidPress: ((String) -> Swift.Void)?
    
    private var leftConstraint: NSLayoutConstraint?
    
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
        searchBar.delegate = self
        
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
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        NSLayoutConstraint.activate([
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        leftConstraint = searchBar.leftAnchor.constraint(equalTo: titleLabel.rightAnchor)
        leftConstraint?.isActive = true
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
            performExpandAnimation()
        case .notActive:
            print(#function)
//            performShrinkAnimation()
        }
    }
    
    func performExpandAnimation() {
        leftConstraint?.constant -= bounds.width - (bounds.height * 1.4)
        setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.3) { [self] in
            titleLabel.alpha = 0.0
            layoutIfNeeded()
        }
    }
    // FIXME
//    func performShrinkAnimation() {
//        searchBar.resignFirstResponder()
//        leftConstraint?.constant += 150
//        setNeedsUpdateConstraints()
//
//        UIView.animate(withDuration: 0.3) { [self] in
//            titleLabel.alpha = 1.0
//            searchBar.transform = CGAffineTransform(scaleX: 1.4, y: 1.0)
//            layoutIfNeeded()
//        }
//    }
}

//MARK: - UISearchBarDelegate

extension DSNavBar: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if state == .notActive {
            bind(state: .active)
        }
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchBar.resignFirstResponder()
        onSearchButtonDidPress?(text)
        searchBar.text = ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(11123971289427190)
    }
}

