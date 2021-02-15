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
    
    private(set) var minValueLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.dirtyBlue.cgColor
        $0.layer.cornerRadius = 8
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private(set) var maxValueLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.dirtyBlue.cgColor
        $0.layer.cornerRadius = 8
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
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
            minValueLabel,
            maxValueLabel,
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
        
        minValueLabel.text = "от \(Int(rangeSlide.selectedMinValue))"
        maxValueLabel.text = "до \(Int(rangeSlide.selectedMaxValue))"
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        
        minValueLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
        }
        
        maxValueLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
        }
        
        [minValueLabel, maxValueLabel].forEach {
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(12)
                $0.height.equalToSuperview().multipliedBy(0.23)
                $0.width.equalToSuperview().multipliedBy(0.43)
            }
        }
        
        rangeSlide.snp.makeConstraints {
            $0.top.equalTo(minValueLabel.snp.bottom).offset(16)
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


