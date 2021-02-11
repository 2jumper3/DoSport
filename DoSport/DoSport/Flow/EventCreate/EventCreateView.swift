//
//  EventCreateView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit
import SnapKit

final class EventCreateView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentSize = CGSize(width: 0, height: stackView.frame.height * 1.4)
        return $0
    }(UIScrollView())
    
    private lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private lazy var descriptiontextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.placeholder
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.font = Fonts.sfProRegular(size: 18)
        $0.textAlignment = .justified
        return $0
    }(UITextView())
    
    private let sportTypesActionStackItem = DSActionStackItem(text: Texts.EventCreate.sportTypes)
    private let playgroundActionStackItem = DSActionStackItem(text: Texts.EventCreate.playground)
    private let dateActionStackItem = DSActionStackItem(text: Texts.EventCreate.date)
    private let eventTypeStackItem = DSEventTypeStackItem()
    private let memberCountStackItem = DSMemberCountStackItem()

    private lazy var createButton = CommonButton(title: Texts.EventCreate.create, state: .disabled)

    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        stackView.addArrangedSubviews(
            descriptiontextView,
            sportTypesActionStackItem,
            playgroundActionStackItem,
            dateActionStackItem,
            memberCountStackItem,
            eventTypeStackItem
        )
        
        scrollView.addSubview(stackView)
        
        addSubviews(scrollView, createButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(12)
            $0.bottom.equalTo(createButton.snp.top).offset(-30)
        }
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        descriptiontextView.snp.makeConstraints { $0.height.equalTo(snp.height).multipliedBy(0.244) }
        sportTypesActionStackItem.snp.makeConstraints { $0.height.equalTo(snp.height).multipliedBy(0.073) }
        playgroundActionStackItem.snp.makeConstraints { $0.height.equalTo(snp.height).multipliedBy(0.073) }
        dateActionStackItem.snp.makeConstraints { $0.height.equalTo(snp.height).multipliedBy(0.073) }
        memberCountStackItem.snp.makeConstraints { $0.height.equalTo(snp.height).multipliedBy(0.252) }
        eventTypeStackItem.snp.makeConstraints { $0.height.equalTo(snp.height).multipliedBy(0.117) }

        createButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.89)
            $0.height.equalTo(42)
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-30)
        }
    }
}

//MARK: - Public Methods

extension EventCreateView {
    
 
}

