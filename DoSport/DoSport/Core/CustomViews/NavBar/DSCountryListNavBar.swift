//
//  DSCountryListNavBar.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

protocol DSCountryListNavBarDelegate: class {
    func searchButtonClicked(with text: String)
    func searchTextChanged(text: String)
    func navBarBackButtonClicked()
}

enum CountryListNavBarState {
    case active, notActive
}

final class DSCountryListNavBar: UIView {
    
    weak var delegate: DSCountryListNavBarDelegate?
    
    var navBarState: CountryListNavBarState = .notActive {
        didSet {
            handleStateChange()
        }
    }
    
    var title: String? {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue}
    }
    
    private var leftConstraint: NSLayoutConstraint?
    
    private lazy var backButton: DSBarBackButton = {
        $0.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return $0
    }(DSBarBackButton())

    
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
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.delegate = self
        
        addSubviews(backButton, titleLabel, searchBar)
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
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.height.centerY.equalToSuperview()
            $0.width.equalTo(snp.height).multipliedBy(1.2)
        }
        
        NSLayoutConstraint.activate([
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        leftConstraint = searchBar.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -5)
        leftConstraint?.isActive = true
    }
}

//MARK: Public API

extension DSCountryListNavBar {
    
    func bind(state: CountryListNavBarState) {
        navBarState = state
    }
    
    func resignSearchBarFirstResponder() {
        searchBar.resignFirstResponder()
    }
}

//MARK: Actions

@objc extension DSCountryListNavBar {
    
    func handleBackButton() {
        searchBar.resignFirstResponder()
        delegate?.navBarBackButtonClicked()
    }
}

//MARK: Private API

private extension DSCountryListNavBar {
    
    func handleStateChange() {
        switch navBarState {
        case .active:
            performExpandAnimation()
        default: break // FIXME: finish this
//            performShrinkAnimation()
        }
    }
    
    func performExpandAnimation() {
        leftConstraint?.constant -= bounds.width - (bounds.height * 1.4) - (backButton.frame.width - 10)
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

//MARK: - UISearchBarDelegate -

extension DSCountryListNavBar: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if navBarState == .notActive {
            bind(state: .active)
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchTextChanged(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        searchBar.resignFirstResponder()
        delegate?.searchButtonClicked(with: text)
    }
}

