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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(menuItems: [TabBarItem], frame: CGRect) {
        self.init(frame: frame)
        self.isUserInteractionEnabled = true

        for item in 0..<menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(item)
            let itemView = self.createTabItem(item: menuItems[item])
            itemView.tag = item
            self.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                    itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                    itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                    itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                    itemView.topAnchor.constraint(equalTo: self.topAnchor)
                ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0)
    }

    // MARK: - Setup UI tabitem
    func createTabItem(item: TabBarItem) -> UIView {
        let tabBarItem = UIView()
        let itemView = UIView()
        let itemIconView = UIImageView()

        itemIconView.tag = 11
        itemIconView.image = item.icon!
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true

        itemView.tag = 10
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.layer.backgroundColor = Colors.darkBlue.cgColor
        itemView.clipsToBounds = true

        tabBarItem.addSubview(itemView)
        itemView.addSubview(itemIconView)

        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: tabBarItem.topAnchor),
            itemView.bottomAnchor.constraint(equalTo: tabBarItem.bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: tabBarItem.trailingAnchor),

            itemIconView.heightAnchor.constraint(equalToConstant: 24),
            itemIconView.widthAnchor.constraint(equalToConstant: 24),
            itemIconView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 20),
            itemIconView.centerXAnchor.constraint(equalTo: itemView.centerXAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tabBarItem.addGestureRecognizer(tapGesture)
        return tabBarItem
    }

    // MARK: - Actions
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, too: sender.view!.tag)
    }

    func switchTab(from: Int, too: Int) {
        deActivateTab(tab: from)
        activateTab(tab: too)
    }

    func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        tabToActivate.viewWithTag(10)?.backgroundColor = Colors.darkBlue
        if let view: UIImageView = tabToActivate.viewWithTag(11) as? UIImageView {
            view.setImageColor(color: .white)
        }
        self.itemTapped?(tab)
        self.activeItem = tab
    }

    func deActivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        inactiveTab.viewWithTag(10)?.backgroundColor = Colors.darkBlue
        if let view: UIImageView = inactiveTab.viewWithTag(11) as? UIImageView {
            view.setImageColor(color: Colors.mainBlue)
        }
    }
}
