//
//  TextViewCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class TextViewCell: UITableViewCell {
    
    private lazy var textView: UITextView = {
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.textAlignment = .justified
        $0.font = Fonts.sfProRegular(size: 18)
        $0.text = Texts.EventCreate.placeholder
        return $0
    }(UITextView())
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.snp.makeConstraints{ $0.edges.equalToSuperview().inset(20) }
    }
}

