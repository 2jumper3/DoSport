//
//  CustomTabView.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//
import UIKit

class CustomTabView: UIView {

    // MARK: - Properties
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0

    // MARK: - Init

     init(menuItems: [TabBarItem], frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        backgroundColor = Colors.darkBlue

        for item in 0..<menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(item)
            let itemView = self.createTabItem(item: menuItems[item])
            itemView.tag = item
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(itemView)

            itemView.snp.makeConstraints { (make) in
                make.height.top.equalToSuperview()
                make.width.equalTo(itemWidth)
                make.leading.equalTo(snp.leading).offset(leadingAnchor)
            }
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        activateTab(tab: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI tabitem
    
    func createTabItem(item: TabBarItem) -> UIView {
        let tabBarItem = UIView()
        let itemIconView = UIImageView()

        itemIconView.tag = 11
        itemIconView.image = item.icon!
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true

        tabBarItem.addSubview(itemIconView)

        
        itemIconView.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.centerX.centerY.equalTo(tabBarItem)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tabBarItem.addGestureRecognizer(tapGesture)
        return tabBarItem
    }

    // MARK: - Actions
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        switchTab(from: activeItem, too: sender.view!.tag)
    }

    func switchTab(from: Int, too: Int) {
        deActivateTab(tab: from)
        activateTab(tab: too)
    }

    func activateTab(tab: Int) {
        let tabToActivate = subviews[tab]
        tabToActivate.viewWithTag(10)?.backgroundColor = Colors.darkBlue
        
        if let view: UIImageView = tabToActivate.viewWithTag(11) as? UIImageView {
            view.setImageColor(color: .white)
        }
        
        itemTapped?(tab)
        activeItem = tab
    }

    func deActivateTab(tab: Int) {
        let inactiveTab = subviews[tab]
        inactiveTab.viewWithTag(10)?.backgroundColor = Colors.darkBlue
        
        if let view: UIImageView = inactiveTab.viewWithTag(11) as? UIImageView {
            view.setImageColor(color: Colors.mainBlue)
        }
    }
}
