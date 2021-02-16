//
//  DSRangeSlider.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit
import RangeSeekSlider

final class DSRangeSlider: RangeSeekSlider {
    
    var onDidChangeValues: ((CGFloat, CGFloat) -> Void)?
    
    enum State {
        case enabled, disabled
    }
    
    private var sliderState: State = .enabled {
        didSet {
            refresh()
        }
    }
    
    private var maxValueBeforeStateChange: CGFloat = 0.0
    private var minValueBeforeStateChange: CGFloat = 0.0
    
    //MARK: - Init
    
    init(state: State) {
        super.init(frame: .zero)
        
        delegate = self
        minValue = 0.0
        selectedMinValue = 3.0
        selectedMaxValue = 40.0
        maxValue = 300.0
        backgroundColor = Colors.darkBlue
        handleColor = .white
        tintColor = .white
        minDistance = 10.0
        handleDiameter = 30.0
        lineHeight = 2
        selectedHandleDiameterMultiplier = 1.2
        handleBorderWidth = 1.5
        colorBetweenHandles = Colors.lightBlue
        handleBorderColor = Colors.lightBlue
        hideLabels = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    override func setupStyle() {
        super.setupStyle()
        
    }
    
    public func refresh() {
        switch sliderState {
        case .enabled:
            tintColor = .white
            colorBetweenHandles = Colors.lightBlue
            handleColor = .white
            handleBorderColor = Colors.lightBlue
            isUserInteractionEnabled = true
            
        case .disabled:
            tintColor = Colors.dirtyBlue
            colorBetweenHandles = Colors.dirtyBlue
            handleBorderColor = Colors.dirtyBlue
            handleColor = Colors.dirtyBlue
            isUserInteractionEnabled = false
        }
        
        minValue = 0.0
        maxValue = 300.0
    }
}

//MARK: - Public methodss

extension DSRangeSlider {
    
    func bind(state: State) {
        maxValueBeforeStateChange = selectedMaxValue
        minValueBeforeStateChange = selectedMinValue
        sliderState = state
    }
}

//MARK: - RangeSeekSliderDelegate

extension DSRangeSlider: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        onDidChangeValues?(minValue, maxValue)
    }
}
