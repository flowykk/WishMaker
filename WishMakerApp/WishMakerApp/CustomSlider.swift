//
//  CustomSliderView.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 31.10.2023.
//

import UIKit

// MARK: - CustomSlider class
final class CustomSlider: UIView {
    
    //MARK: - fields
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK: - custom sliders constructor
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.sliderTitleFontSize)
        titleView.textColor = .black
        
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure UI for CustomSliders
    private func configureUI() {
        backgroundColor = Constants.viewColor
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.sliderTitleTopAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingAnchor),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderCenterXAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingAnchor)
        ])
    }
}
