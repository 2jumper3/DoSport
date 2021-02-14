//
//  DSSegmentedControl.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

protocol DSSegmentedControlDelegate: class {
    func didSelectItem(at: Int)
}

final class DSSegmentedControl: UIView {
    
    weak var delegate: DSSegmentedControlDelegate?
    
    private let titles: [String]
    
    private var selectedItemIndex: Int = 0
    
    private var buttons: [UIButton] = []
    
    private let staticSeparatorView: DSSeparatorView = DSSeparatorView()
    private let movableSeparatorView: DSSeparatorView = DSSeparatorView(color: .white)
    
    //MARK: - Init
    
    init(titles: [String]) {
        self.titles = titles
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        initialiseButtons()
        
        addSubviews(staticSeparatorView, movableSeparatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth = Int(self.frame.width) / buttons.count
        var buttonLeft = 0
        
        for button in buttons {
            
            button.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.9)
                $0.width.equalTo(buttonWidth)
                $0.left.equalToSuperview().offset(buttonLeft)
            }
            
            buttonLeft += buttonWidth
        }
        
        staticSeparatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-2)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        movableSeparatorView.snp.makeConstraints {
            $0.bottom.equalTo(staticSeparatorView.snp.bottom)
            $0.width.equalTo(buttonWidth)
            $0.left.equalToSuperview()
            $0.height.equalTo(1.5)
        }
    }
}

//MARK: - Public methods

extension DSSegmentedControl {
    
    func getSelectedItemIndex() -> Int {
        return selectedItemIndex
    }
    
    func setSelectedItemIndex(_ index: Int) {
        self.selectedItemIndex = index
    }
    
    func setTitle(_ title: String, forItemAt index: Int) {
        
        for (i, button) in buttons.enumerated() {
            
            if index == i {
                button.setTitle(title, for: .normal)
            }
        }
    }
    
    func setTitleStyle(fontSize size: CGFloat) {
        buttons.forEach { button in
            button.titleLabel?.font = Fonts.sfProRegular(size: size)
        }
    }
}

//MARK: - Actions

@objc
private extension DSSegmentedControl {
    
    func handleButton(_ button: UIButton) {
        moveSeletectedItem(to: button.tag)
        delegate?.didSelectItem(at: button.tag)
    }
}

//MARK: - Private methods

private extension DSSegmentedControl {
    
    func initialiseButtons() {
        
        for (i, title) in titles.enumerated() {
            
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
            
            if i == selectedItemIndex {
                button.setTitleColor(.white, for: .normal)
            } else {
                button.setTitleColor(Colors.mainBlue, for: .normal)
            }
            
            buttons.append(button)
            addSubview(button)
        }
    }
    
    func moveSeletectedItem(to index: Int) {
        
        for (i, button) in buttons.enumerated() {
            if i == index {
                UIView.animate(withDuration: 0.2) { [self] in
                    button.setTitleColor(.white, for: .normal)
                    movableSeparatorView.transform = CGAffineTransform(translationX: button.frame.origin.x, y: 0)
                }
            } else {
                button.setTitleColor(Colors.mainBlue, for: .normal)
            }
        }
    }
}
