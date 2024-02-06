//
//  WishStoringViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 31.10.2023.
//

import UIKit

final class WishEventCreationViewController: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate {
    
    //MARK: - fields
    
    @available(iOS 15.0, *)
    var wishStoringController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }

    private let wrap = UIView()
    private let warningLabel = UILabel()
    private let titleLabel = UILabel()
    private let startDateLabel = UILabel()
    private let startDatePicker = UIDatePicker()
    private let endDateLabel = UILabel()
    private let endDatePicker = UIDatePicker()
    private let wishDescriptionLabel = UILabel()
    private let wishDescriptionTextField: UITextField = UITextField()
    private let continueButton = UIButton()
    
    private let randomColor = UIColor.generateRandomColor()
    
    private var wishCalendarViewController = WishCalendarViewController()
    private var eventTitle = String()
    
    init(_ eventTitle: String) {
        self.eventTitle = eventTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad func
    override func viewDidLoad() {
        view.backgroundColor = .white
                
        if #available(iOS 15.0, *) {
            sheetPresentationController?.delegate = self
            sheetPresentationController?.prefersGrabberVisible = true
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        configureUI()
    }

    //MARK: - function to hide keyboard
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    //MARK: - configure UI
    private func configureUI() {
        configureTitleLabel()
        
        configureWrap()
        
        configureStartDateLabel()
        configureStartDatePicker()
        
        configureEndDateLabel()
        configureEndDatePicker()
        
        configureWishDescriptionLabel()
        configureWishDescriptionTextField()
        
        configureContinueButton()
        configureWarningLabel()
    }
    
    //MARK: - configure title label
    private func configureTitleLabel() {
        titleLabel.text = Constants.createWishTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.createWishTitleFontSize)
        titleLabel.textColor = randomColor
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.createWishTitleTopAnchor)
    }
    
    //MARK: - configure wrap
    private func configureWrap() {
        wrap.setHeight(Constants.createWishWrapHeight)
        
        view.addSubview(wrap)
        wrap.pinHorizontal(to: view, Constants.createWishWrapHOffset)
        wrap.pinCenter(to: view)
    }
    
    //MARK: - configure label for startDate
    private func configureStartDateLabel() {
        startDateLabel.text = Constants.startDateLabel
        startDateLabel.font = UIFont.boldSystemFont(ofSize: Constants.createWishLabelsFontSize)
        startDateLabel.textColor = randomColor
        startDateLabel.textAlignment = .center
        
        wrap.addSubview(startDateLabel)
        startDateLabel.pinCenterX(to: wrap)
        startDateLabel.pinTop(to: wrap.topAnchor, Constants.startDateLabelTopAnchor)
    }
    
    //MARK: - configure picker for startDate
    private func configureStartDatePicker() {
        startDatePicker.locale = .current
        startDatePicker.datePickerMode = .date
        startDatePicker.setValue(UIColor.white, forKeyPath: Constants.startDateKeyPath)
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.tintColor = randomColor
        
        wrap.addSubview(startDatePicker)
        startDatePicker.pinCenterX(to: wrap)
        startDatePicker.pinTop(to: startDateLabel.bottomAnchor, Constants.startDatePickerTopAnchor)
    }
    
    //MARK: - configure label for endDate
    private func configureEndDateLabel() {
        endDateLabel.text = Constants.endDateLabel
        endDateLabel.font = UIFont.boldSystemFont(ofSize: Constants.createWishLabelsFontSize)
        endDateLabel.textColor = randomColor
        endDateLabel.textAlignment = .center
        
        wrap.addSubview(endDateLabel)
        endDateLabel.pinCenterX(to: wrap)
        endDateLabel.pinTop(to: startDatePicker.bottomAnchor, Constants.endDatePickerTopAnchor)
    }
    
    //MARK: - configure picker for endDate
    private func configureEndDatePicker() {
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = .now.addingTimeInterval(Constants.timeAddingInterval)
        endDatePicker.preferredDatePickerStyle = .compact
        endDatePicker.tintColor = randomColor
        wrap.addSubview(endDatePicker)
        endDatePicker.pinTop(to: endDateLabel.bottomAnchor, Constants.startDatePickerTopAnchor)
        endDatePicker.pinCenterX(to: wrap)
    }
    
    //MARK: - configure label for WishDescription
    private func configureWishDescriptionLabel() {
        wishDescriptionLabel.text = Constants.wishDescriptionLabelText
        wishDescriptionLabel.font = UIFont.boldSystemFont(ofSize: Constants.createWishLabelsFontSize)
        wishDescriptionLabel.textColor = randomColor
        wishDescriptionLabel.textAlignment = .center
        
        wrap.addSubview(wishDescriptionLabel)
        wishDescriptionLabel.pinCenterX(to: wrap)
        wishDescriptionLabel.pinTop(to: endDatePicker.bottomAnchor, Constants.endDatePickerTopAnchor)
    }
    
    //MARK: - configure textField for wishDescription
    private func configureWishDescriptionTextField() {
        wishDescriptionTextField.placeholder = Constants.wishDescriptionTextFieldPlaceHolder
        wishDescriptionTextField.textAlignment = .center

        wrap.addSubview(wishDescriptionTextField)
        wishDescriptionTextField.pinTop(to: wishDescriptionLabel.bottomAnchor, Constants.wishDescriptionTextFieldTopAnchor)
        wishDescriptionTextField.pinHorizontal(to: wrap, Constants.wishDescriptionTextFieldHOffset)
        wishDescriptionTextField.setHeight(Constants.wishDescriptionTextFieldHeight)
    }
    
    //MARK: - configure warning label
    private func configureWarningLabel() {
        warningLabel.text = String()
        warningLabel.font = UIFont.boldSystemFont(ofSize: Constants.warningLabelFontSize)
        warningLabel.textColor = randomColor
        warningLabel.textAlignment = .center
        
        view.addSubview(warningLabel)
        warningLabel.pinCenterX(to: wrap)
        warningLabel.pinBottom(to: continueButton.topAnchor, Constants.warningLabelBottomAnchor)
    }
    
    //MARK: - configure continueButton
    private func configureContinueButton() {
        continueButton.setTitle(Constants.continueButtonText, for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.continueButtonFontSize)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = randomColor
        continueButton.layer.cornerRadius = Constants.continueButtonCornerRadius
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.setHeight(Constants.continueButtonHeight)
        continueButton.setWidth(Constants.continueButtonWidth)
        continueButton.pinCenterX(to: view)
        continueButton.pinBottom(to: view.bottomAnchor, Constants.continueButtonBottomAnchor)
    }
    
    
    //MARK: - Continue button was pressed
    @objc
    private func continueButtonPressed() {
        if wishDescriptionTextField.text!.isEmpty {
            warningLabel.text = Constants.invalidDescriptionWarning
            return
        }
                
        if !compareDates() {
            warningLabel.text = Constants.invalidDatesWarning
            return
        }
        
        wishCalendarViewController.createItem(
            wishEventTitle: eventTitle,
            wishEventDescription: wishDescriptionTextField.text!,
            startDate: startDatePicker.date,
            endDate: endDatePicker.date
        )
        
        dismiss(animated: true)
    }
    
    //MARK: - function for comparing dates
    private func compareDates() -> Bool {
        let startDate = startDatePicker.date.removeTimeFromDate
        let endDate = endDatePicker.date.removeTimeFromDate
        
        if startDate.count > endDate.count || startDate >= endDate {
            return false
        }
        return true
    }
}
