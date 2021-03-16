//
//  VKLoginView.swift
//  DoSport
//
//  Created by Sergey on 12.03.2021.
//

import UIKit
import WebKit

class VKLoginView: UIView, WKNavigationDelegate  {
    
    var delegate: BtnActionDelegate?
    
    private(set) lazy var  loginVKBtn: UIButton =  {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login via VK", for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btn.backgroundColor = .red
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.addSubview(loginVKBtn)
        self.backgroundColor = .black

        
         NSLayoutConstraint.activate([
             self.loginVKBtn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 400),
             self.loginVKBtn.widthAnchor.constraint(equalToConstant: 200),
             self.loginVKBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 100),
             self.loginVKBtn.heightAnchor.constraint(equalToConstant: 20)
             
         ])
     }
    
    @objc func btnTapped() {
        delegate?.openVC()
    }

}
