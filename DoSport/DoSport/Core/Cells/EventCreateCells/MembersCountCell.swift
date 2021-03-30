//
//  MembersCountCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class MembersCountCell: UITableViewCell {
    
    // MARK: Outlets
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.memberCount
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private let maxValueTextField: DSTextField = {
        $0.backgroundColor = Colors.darkBlue
        $0.isUserInteractionEnabled = false
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(DSTextField())
    
    private lazy var maxMembersCountSlider: UISlider = {
        $0.addTarget(self, action: #selector(handleSliderValueChanged), for: .allEvents)
        $0.minimumTrackTintColor = Colors.lightBlue
        $0.maximumTrackTintColor = .white
        $0.maximumValue = 100
        $0.minimumValue = 1
        $0.value = 10
        return $0
    }(UISlider())
    
    private lazy var checkboxButton = UIButton.makeCheckboxButton()

    private let checkboxInfoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.noLimit
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 16)
        return $0
    }(UILabel())

    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        checkboxButton.addTarget(self, action: #selector(handleCheckbocButton))
        
        contentView.addSubviews(
            titleLabel,
            maxValueTextField,
            maxMembersCountSlider,
            checkboxButton,
            checkboxInfoLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maxValueTextField.text = "до \(Int(maxMembersCountSlider.value))"
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(25)
        }
        
        maxValueTextField.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.height.equalToSuperview().multipliedBy(0.23)
            $0.right.equalToSuperview().offset(-16)
        }
        
        maxMembersCountSlider.snp.makeConstraints {
            $0.top.equalTo(maxValueTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        checkboxButton.snp.makeConstraints {
            $0.top.equalTo(maxMembersCountSlider.snp.bottom).offset(18)
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

//MARK: Actions

@objc private extension MembersCountCell {
    
    func handleSliderValueChanged(_ slider: UISlider) {
        let step: Float = 1
        let roundedValue = round(slider.value / step) * step
        self.maxValueTextField.text = "до \(Int(roundedValue))"
    }
    
    func handleCheckbocButton() {
        checkboxButton.bindCheckboxButtonState()
        
        switch checkboxButton.checkboxButtonState {
        case .notSelected:
            maxMembersCountSlider.minimumTrackTintColor = Colors.lightBlue
            maxMembersCountSlider.maximumTrackTintColor = .white
            maxMembersCountSlider.thumbTintColor = .white
            maxMembersCountSlider.isUserInteractionEnabled = true
            maxValueTextField.bind(state: .enable)
        case .selected:
            maxMembersCountSlider.isUserInteractionEnabled = false
            maxMembersCountSlider.thumbTintColor = Colors.dirtyBlue
            maxMembersCountSlider.minimumTrackTintColor = Colors.dirtyBlue
            maxMembersCountSlider.maximumTrackTintColor = Colors.dirtyBlue
            maxValueTextField.bind(state: .disabled)
        }
    }
}
