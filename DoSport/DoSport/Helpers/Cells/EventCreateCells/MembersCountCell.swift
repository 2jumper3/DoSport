//
//  MembersCountCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class MembersCountCell: UITableViewCell {
    
    var onRangeSliderDidChangeValues: ((CGFloat, CGFloat) -> Void)?
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.memberCount
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private(set) var minValueTextField: DSTextField = {
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = Colors.darkBlue
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(DSTextField())
    
    private(set) var maxValueTextField: DSTextField = {
        $0.backgroundColor = Colors.darkBlue
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(DSTextField())
    
    private(set) lazy var rangeSlide = DSRangeSlider(state: .enabled)
    
    private(set) lazy var checkboxButton = DSCheckboxButton()

    private let checkboxInfoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.noLimit
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 16)
        return $0
    }(UILabel())

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            minValueTextField,
            maxValueTextField,
            rangeSlide,
            checkboxButton,
            checkboxInfoLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        minValueTextField.text = "от  \(Int(rangeSlide.selectedMinValue))"
        maxValueTextField.text = "до  \(Int(rangeSlide.selectedMaxValue))"
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        
        minValueTextField.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
        }
        
        maxValueTextField.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
        }
        
        [minValueTextField, maxValueTextField].forEach {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.height.equalToSuperview().multipliedBy(0.23)
                $0.width.equalToSuperview().multipliedBy(0.43)
            }
        }
        
        rangeSlide.snp.makeConstraints {
            $0.top.equalTo(minValueTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.122)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        checkboxButton.snp.makeConstraints {
            $0.top.equalTo(rangeSlide.snp.bottom).offset(18)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalToSuperview().multipliedBy(0.156)
            $0.width.equalTo(checkboxButton.snp.height)
        }
        
        checkboxInfoLabel.snp.makeConstraints {
            $0.top.equalTo(checkboxButton.snp.top)
            $0.left.equalTo(checkboxButton.snp.right).offset(12)
            $0.height.equalTo(checkboxButton.snp.height)
        }
    }
}


