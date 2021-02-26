//
//  InvitesFriendView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

protocol InviteFriendsViewDelegate: class {
    func cancelButtonClicked()
    func shareButtonClicked()
    func sendButtonClicked()
    func searchCancelButtonClicked()
    func searchBarTextChanged(text: String?)
    func inputTextChanged(text: String?)
}

final class InvitesFriendView: UIView {
    
    weak var delegate: InviteFriendsViewDelegate?
    
    var isSearhing: Bool = false {
        didSet {
            handleStateChange()
        }
    }
    
    //MARK: Outlets
    
    private let containerView: UIView = {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = Colors.mainBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.text = Texts.Feed.invite
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private let subTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.font = Fonts.sfProRegular(size: 14)
        $0.text = Texts.Feed.selectChat
        $0.textColor = Colors.lightBlue
        return $0
    }(UILabel())
    
    private let textInputView = DSMessageInputView(
        backgroundColor: Colors.mainBlue,
        borderColor: .white,
        textColor: .white,
        placeholderColor: .white
    )
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.mainBlue
        collectionView.registerClass(ShareMemberCollectionCell.self)
        collectionView.layer.cornerRadius = 8
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        $0.isHidden = true
        $0.alpha = 0.0
        $0.compatibleSearchTextField.backgroundColor = Colors.mainBlue
        $0.compatibleSearchTextField.textColor = .white
        $0.compatibleSearchTextField.layer.borderColor = UIColor.white.cgColor
        $0.compatibleSearchTextField.layer.borderWidth = 1
        $0.compatibleSearchTextField.layer.cornerRadius = 8
        $0.setImage(Icons.Event.search, for: .search, state: .normal)
        $0.showsCancelButton = true
        $0.barTintColor = .clear
        $0.backgroundColor = .clear
        $0.isTranslucent = true
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.isUserInteractionEnabled = false
        return $0
    }(UISearchBar())

    
    private lazy var searchButton: UIButton = {
        $0.backgroundColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(Icons.Event.search, for: .normal)
        $0.addTarget(self, action: #selector(handleSearchButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var shareButton: UIButton = {
        $0.backgroundColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(Icons.Event.share, for: .normal)
        $0.addTarget(self, action: #selector(handleShareButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var cancelButton: UIButton = {
        $0.backgroundColor = Colors.mainBlue
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle(Texts.Feed.cancel, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(handleCancelButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    
    //MARK: Init

    init() {
        super.init(frame: .zero)
        
        textInputView.delegate = self
        searchBar.delegate = self
        
        containerView.addSubviews(
            searchBar,
            searchButton,
            titleLabel,
            subTitleLabel,
            shareButton,
            collectionView,
            textInputView
        )
        
        addSubviews(containerView, cancelButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(315)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-12)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(16)
            $0.width.equalTo(23)
            $0.height.equalTo(23)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(26)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(-5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(26)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(23)
            $0.height.equalTo(23)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(22)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(textInputView.snp.top).offset(-10)
        }
        
        textInputView.snp.makeConstraints {
            $0.height.equalTo(65)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        let cancelButtonBottom = UIDevice.deviceSize == .big ? 25 : 10
        cancelButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.bottom.equalToSuperview().offset(-cancelButtonBottom)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Public API

extension InvitesFriendView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func makeContainerViewAnimation(offset: CGAffineTransform) {
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
            containerView.transform = offset
        }.startAnimation()
    }
    
    func makeMessageInputBarFirstResponder() {
        self.textInputView.makeTextFieldFirstResponder()
    }
    
    func removeMessageInputBarFirstResponder() {
        textInputView.removeTextFieldFirstResponder()
    }
    
    func getCancelButtonHeight() -> CGFloat {
        return cancelButton.frame.height
    }
}

//MARK: Actions

@objc private extension InvitesFriendView {
    
    func handleCancelButton() {
        delegate?.cancelButtonClicked()
    }
    
    func handleSearchButton() {
        isSearhing = true
    }
    
    func handleShareButton() {
        
    }
    
    func handleStateChange() {
        if isSearhing {
            searchBar.becomeFirstResponder()
            searchBar.isHidden = false
            searchBar.isUserInteractionEnabled = true
            
            [searchButton, shareButton, textInputView, titleLabel, subTitleLabel].forEach {
                $0.isHidden = true
                $0.isUserInteractionEnabled = false
            }
            
            UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
                collectionView.transform = CGAffineTransform(translationX: 0, y: -15)
                collectionView.frame.size.height += textInputView.frame.height
                searchBar.alpha = 1.0
                [searchButton, shareButton, textInputView, titleLabel, subTitleLabel].forEach { $0.alpha = 0.0 }
            }.startAnimation()
        } else {
            searchBar.resignFirstResponder()
            searchBar.text = ""
            searchBar.isHidden = true
            searchBar.isUserInteractionEnabled = false
            
            [searchButton, shareButton, textInputView, titleLabel, subTitleLabel].forEach {
                $0.isHidden = false
                $0.isUserInteractionEnabled = true
            }
            
            UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
                collectionView.transform = .identity
                collectionView.frame.size.height -= textInputView.frame.height
                searchBar.alpha = 0.0
                [searchButton, shareButton, textInputView, titleLabel, subTitleLabel].forEach { $0.alpha = 1.0 }
            }.startAnimation()
        }
    }
}

//MARK: - DSTextInputViewDelegate -

extension InvitesFriendView: DSTextInputViewDelegate {
    
    func sendTextButtonClicked() {
        delegate?.sendButtonClicked()
    }
    
    func textFieldValueChaged(text: String?) {
        delegate?.inputTextChanged(text: text)
    }
}

//MARK: - UISearchBarDelegate -

extension InvitesFriendView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarTextChanged(text: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.searchCancelButtonClicked()
        isSearhing = false
    }
}


