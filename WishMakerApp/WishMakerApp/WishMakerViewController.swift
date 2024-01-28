//
//  ViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 26.09.2023.
//

import UIKit

// MARK: - WishMakerViewController class
class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    // MARK: - fields
    var alertController: UIAlertController?
    var baseMessage: String?
    
    var previousColor = Constants.defaultPreviousColor

    let slidersStack = UIStackView()
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let colorLabel = UILabel()
    let colorDescriptionLabel = UILabel()
    
    let hideButton: UIButton = UIButton(type: .system)
    let randomColorButton: UIButton = UIButton(type: .system)
    let previousColorButton: UIButton = UIButton(type: .system)
    let colorPickerButton: UIButton = UIButton(type: .system)
    let showWishButton: UIButton = UIButton(type: .system)
    let ScheduleWishButton: UIButton = UIButton(type: .system)
        
    let sliderRed = CustomSlider(title: Constants.red, min: Constants.colorMin, max: Constants.colorMax)
    let sliderGreen = CustomSlider(title: Constants.green, min: Constants.colorMin, max: Constants.colorMax)
    let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.colorMin, max: Constants.colorMax)
    
    // MARK: - viewDidLoad func
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - configure UI
    private func configureUI() {
        let color = UIColor(
            red: .random(in: Constants.colorMin...Constants.colorMax),
            green: .random(in: Constants.colorMin...Constants.colorMax),
            blue: .random(in: Constants.colorMin...Constants.colorMax),
            alpha: Constants.alphaValue
        )
        
        configureTitle()
        configureDescription()
        configureColor()
        configureColorDescription()
        configureButtons()
        configureSliders()
        
        ChangeColors(color: color)
    }
    
    // MARK: - configure all buttons
    private func configureButtons() {
        configureScheduleWishButton()
        configureShowWishButton()
        configureHideButton()
        configurePreviousColorButton()
        configureRandomColorButton()
        configureColorPickerButton()
    }
    
    //MARK: - configure schedule wishes button
    private func configureScheduleWishButton() {
        ScheduleWishButton.setTitle(Constants.ScheduleWishButtonTitle, for: .normal)
        ScheduleWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        ScheduleWishButton.setTitleColor(.black, for: .normal)
        ScheduleWishButton.backgroundColor = Constants.viewColor
        ScheduleWishButton.layer.cornerRadius = Constants.buttonsCornerRadius
        ScheduleWishButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(ScheduleWishButton)
        ScheduleWishButton.setHeight(Constants.buttonsHeightAnchor)
        ScheduleWishButton.pinHorizontal(to: view, Constants.leadingAnchor)
        ScheduleWishButton.pinBottom(to: view.bottomAnchor, Constants.buttonsViewBottomAnchor)
    }
    
    //MARK: - configure show wishes button
    private func configureShowWishButton() {
        showWishButton.setTitle(Constants.showWishButtonTitle, for: .normal)
        showWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        showWishButton.setTitleColor(.black, for: .normal)
        showWishButton.backgroundColor = Constants.viewColor
        showWishButton.layer.cornerRadius = Constants.buttonsCornerRadius
        showWishButton.addTarget(self, action: #selector(showWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(showWishButton)
        showWishButton.setHeight(Constants.buttonsHeightAnchor)
        showWishButton.pinHorizontal(to: view, Constants.leadingAnchor)
        showWishButton.pinBottom(to: ScheduleWishButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    //MARK: - configure hide button
    private func configureHideButton() {
        hideButton.setTitle(Constants.hideButtonTitle, for: .normal)
        hideButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        hideButton.setTitleColor(.black, for: .normal)
        hideButton.backgroundColor = Constants.viewColor
        hideButton.layer.cornerRadius = Constants.buttonsCornerRadius
        hideButton.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        
        view.addSubview(hideButton)
        hideButton.setHeight(Constants.buttonsHeightAnchor)
        hideButton.pinHorizontal(to: view, Constants.leadingAnchor)
        hideButton.pinBottom(to: showWishButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    //MARK: - configure previousColor button
    private func configurePreviousColorButton() {
        previousColorButton.setTitle(Constants.previousColorButtonTitle, for: .normal)
        previousColorButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        previousColorButton.setTitleColor(.black, for: .normal)
        previousColorButton.backgroundColor = Constants.viewColor
        previousColorButton.layer.cornerRadius = Constants.buttonsCornerRadius
        previousColorButton.addTarget(self, action: #selector(previousColorButtonPressed), for: .touchUpInside)
        
        previousColorButton.isEnabled = false
        
        view.addSubview(previousColorButton)
        previousColorButton.setHeight(Constants.buttonsHeightAnchor)
        previousColorButton.pinHorizontal(to: view, Constants.leadingAnchor)
        previousColorButton.pinBottom(to: hideButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    // MARK: - configure randomColor button
    private func configureRandomColorButton() {
        randomColorButton.setTitle(Constants.randomColorButtonTitle, for: .normal)
        randomColorButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.backgroundColor = Constants.viewColor
        randomColorButton.layer.cornerRadius = Constants.buttonsCornerRadius
        randomColorButton.addTarget(self, action: #selector(randomColorButtonPressed), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        randomColorButton.setHeight(Constants.buttonsHeightAnchor)
        randomColorButton.pinHorizontal(to: view, Constants.leadingAnchor)
        randomColorButton.pinBottom(to: previousColorButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    // MARK: - configure colorPicker button
    private func configureColorPickerButton() {
        colorPickerButton.setTitle(Constants.colorPickerButtonTitle, for: .normal)
        colorPickerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        colorPickerButton.setTitleColor(.black, for: .normal)
        colorPickerButton.backgroundColor = Constants.viewColor
        colorPickerButton.layer.cornerRadius = Constants.buttonsCornerRadius
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonPressed), for: .touchUpInside)
        
        view.addSubview(colorPickerButton)
        colorPickerButton.setHeight(Constants.buttonsHeightAnchor)
        colorPickerButton.pinHorizontal(to: view, Constants.leadingAnchor)
        colorPickerButton.pinBottom(to: randomColorButton.topAnchor, Constants.buttonsBottomAnchor)
    }
    
    // MARK: - configure title
    private func configureTitle() {
        titleLabel.text = Constants.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.viewColor
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTopAnchor)
    }
    
    // MARK: - configure description
    private func configureDescription() {
        descriptionLabel.text = Constants.description
        descriptionLabel.numberOfLines = Constants.descriptionNumberOfLines
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = Constants.viewColor
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinCenterX(to: view)
        descriptionLabel.pinHorizontal(to: view, Constants.leadingAnchor)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTopAnchor)
    }
    
    // MARK: - configure hex color label
    private func configureColor() {
        colorLabel.text = Constants.defaultColorLabelText
        colorLabel.font = UIFont(name: "SFMono-Regular", size: Constants.colorLabelFontSize)
        colorLabel.textColor = Constants.viewColor
        colorLabel.textAlignment = .center
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(colorLabelTapped))
        colorLabel.isUserInteractionEnabled = true
        colorLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(colorLabel)
        colorLabel.pinCenterX(to: view)
        colorLabel.pinHorizontal(to: view, Constants.leadingAnchor)
        colorLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.descriptionTopAnchor)
    }
    
    //MARK: - configure description of copy color feature
    private func configureColorDescription() {
        colorDescriptionLabel.text = Constants.defaultColorDescriptionLabelText
        colorDescriptionLabel.font = UIFont(name: "SFMono-Regular", size: Constants.colorDescriptionLabelFontSize)
        colorDescriptionLabel.textColor = Constants.viewColor
        colorDescriptionLabel.textAlignment = .center
        
        view.addSubview(colorDescriptionLabel)
        colorDescriptionLabel.pinCenterX(to: view)
        colorDescriptionLabel.pinHorizontal(to: view, Constants.leadingAnchor)
        colorDescriptionLabel.pinTop(to: colorLabel.bottomAnchor, Constants.colorDescriptionTopAnchor)
    }
    
    // MARK: - configure sliders
    private func configureSliders() {
        slidersStack.axis = .vertical
        slidersStack.layer.cornerRadius = Constants.slidersCornerRadius
        slidersStack.clipsToBounds = true
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slidersStack.addArrangedSubview(slider)
        }
        
        view.addSubview(slidersStack)
        slidersStack.pinCenterX(to: view)
        slidersStack.pinHorizontal(to: view, Constants.leadingAnchor)
        slidersStack.pinBottom(to: colorPickerButton.topAnchor, Constants.slidersBottomAnchor)
        
        sliderRed.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        sliderGreen.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        sliderBlue.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    //MARK: - scheduleWishButton was pressed
    @objc
    private func scheduleWishButtonPressed() {
        let vc = WishCalendarViewController()
        
        navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - showWishButton was pressed
    @objc
    private func showWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    //MARK: - hideButton was pressed
    @objc
    private func hideButtonPressed() {
        self.slidersStack.isHidden = !self.slidersStack.isHidden
    }
    
    
    //MARK: - previousColorButton was pressed
    @objc
    private func previousColorButtonPressed() {
        AnimateColorChange(color: previousColor)
        self.previousColorButton.isEnabled = false
    }
    
    //MARK: - randomColorButton was pressed
    @objc
    private func randomColorButtonPressed() {
        previousColor = view.backgroundColor!
        self.previousColorButton.isEnabled = true
        
        let previousColor = UIColor(
            red: .random(in: Constants.colorMin...Constants.colorMax),
            green: .random(in: Constants.colorMin...Constants.colorMax),
            blue: .random(in: Constants.colorMin...Constants.colorMax),
            alpha: Constants.alphaValue
        )
        
        AnimateColorChange(color: previousColor)
    }
    
    //MARK: - colorPickerButton was pressed
    @objc
    private func colorPickerButtonPressed() {
        if #available(iOS 14.0, *) {
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            present(colorPicker, animated: true)
        }
    }
    
    //MARK: - color in colorPicker was changed
    @available(iOS 14.0, *)
    internal func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        UIView.animate(withDuration: Constants.colorPickerAnimationDur) {
            self.ChangeColors(color: viewController.selectedColor)
        }
    }
    
    //MARK: - sliderValue was changed
    @objc
    private func sliderValueChanged() {
        let color = UIColor(
            red: CGFloat(self.sliderRed.slider.value),
            green: CGFloat(self.sliderGreen.slider.value),
            blue: CGFloat(self.sliderBlue.slider.value), alpha: Constants.alphaValue
        )
        
        self.ChangeColors(color: color)
    }
    
    //MARK: - colorLabel was tapped
    @objc
    private func colorLabelTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {
            return
        }
        
        UIPasteboard.general.string = label.text
        self.showCopyColorAlert(title: "Color was copied", message: "You can use this color in any other app")
    }
    
    //MARK: - show alerta after copying the color
    func showCopyColorAlert(title: String, message: String) {
        guard (self.alertController == nil) else {
            return
        }

        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.alertController = nil;
        }
        self.alertController!.addAction(cancelAction)
        
        self.present(self.alertController!, animated: true, completion: nil)
    }
    
    //MARK: - getting background color
    public func getBackgroundColor() -> [CGFloat] {
        if let backgroundColor = view.backgroundColor {
            if let components = backgroundColor.cgColor.components {
                let red = components[Constants.redComponent]
                let green = components[Constants.greenComponent]
                let blue = components[Constants.blueComponent]
                return [red, green, blue]
            }
        }
        
        return [Constants.defaultComponent, Constants.defaultComponent, Constants.defaultComponent]
    }
    
    private func AnimateColorChange(color: UIColor) {
        UIView.animate(
            withDuration: Constants.randomColorAnimationDur,
            animations: {
                self.ChangeColors(color: color)
            },
            completion: { [weak self] _ in
                self?.randomColorButton.isEnabled = true
            }
        )
    }
    
    // MARK: - ChangeColors method
    private func ChangeColors(color: UIColor) {
        view.backgroundColor = color
        self.sliderRed.slider.minimumTrackTintColor = color
        self.sliderGreen.slider.minimumTrackTintColor = color
        self.sliderBlue.slider.minimumTrackTintColor = color
        
        let backgroundColorComponents = self.getBackgroundColor()
        
        let hexString = String.init(
            format: Constants.colorLabelFormat,
            lroundf(Float(backgroundColorComponents[Constants.redComponent] * Constants.maxColorNumber)),
            lroundf(Float(backgroundColorComponents[Constants.greenComponent] * Constants.maxColorNumber)),
            lroundf(Float(backgroundColorComponents[Constants.blueComponent] * Constants.maxColorNumber))
        )
        self.colorLabel.text = hexString
        
        self.sliderRed.slider.value = Float(backgroundColorComponents[Constants.redComponent])
        self.sliderGreen.slider.value = Float(backgroundColorComponents[Constants.greenComponent])
        self.sliderBlue.slider.value = Float(backgroundColorComponents[Constants.blueComponent])
    }
}

