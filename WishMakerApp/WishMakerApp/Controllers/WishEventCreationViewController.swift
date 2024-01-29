//
//  WishStoringViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 31.10.2023.
//

import UIKit

final class WishEventCreationViewController: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate {
    
    //MARK: - fields
    var wraps: [UIView] = []
    
    @available(iOS 15.0, *)
    var wishStoringController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }

    let warningLabel = UILabel()

    let wrap = UIView()
    
    let titleLabel = UILabel()
    
    let startDateLabel = UILabel()
    let startDatePicker = UIDatePicker()
    
    let endDateLabel = UILabel()
    let endDatePicker = UIDatePicker()
    
    let wishDescriptionLabel = UILabel()
    let wishDescriptionTextField: UITextField = UITextField()
    
    let continueButton = UIButton()
    
    let randomColor = generateRandomColor()
    
    // MARK: - viewDidLoad func
    override func viewDidLoad() {
        view.backgroundColor = .white
                
        if #available(iOS 15.0, *) {
            sheetPresentationController?.delegate = self
            sheetPresentationController?.prefersGrabberVisible = true
        }
        
        configureUI()
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
        titleLabel.text = "Schedule your wish"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = randomColor
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 35)
    }
    
    private func configureWrap() {
        wrap.setHeight(350)
        
        view.addSubview(wrap)
        wrap.pinHorizontal(to: view, 15)
        wrap.pinCenter(to: view)
    }
    
    //MARK: - configure label for startDate
    private func configureStartDateLabel() {
        startDateLabel.text = "Select start date"
        startDateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        startDateLabel.textColor = randomColor //.black
        startDateLabel.textAlignment = .center
        
        wrap.addSubview(startDateLabel)
        startDateLabel.pinCenterX(to: wrap)
        startDateLabel.pinTop(to: wrap.topAnchor, 30)
    }
    
    //MARK: - configure picker for startDate
    private func configureStartDatePicker() {
        startDatePicker.locale = .current
        startDatePicker.datePickerMode = .date
        startDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.tintColor = randomColor //.systemGreen
        
        wrap.addSubview(startDatePicker)
        startDatePicker.pinTop(to: startDateLabel.bottomAnchor, 8)
        startDatePicker.pinCenterX(to: wrap)
    }
    
    //MARK: - configure label for endDate
    private func configureEndDateLabel() {
        endDateLabel.text = "Select end date"
        endDateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        endDateLabel.textColor = randomColor //.black
        endDateLabel.textAlignment = .center
        
        wrap.addSubview(endDateLabel)
        endDateLabel.pinCenterX(to: wrap)
        endDateLabel.pinTop(to: startDatePicker.bottomAnchor, 20)
    }
    
    //MARK: - configure picker for endDate
    private func configureEndDatePicker() {
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = .now.addingTimeInterval(24 * 60 * 60)
        endDatePicker.preferredDatePickerStyle = .compact
        endDatePicker.tintColor = randomColor //.systemGreen
        
        wrap.addSubview(endDatePicker)
        endDatePicker.pinTop(to: endDateLabel.bottomAnchor, 8)
        endDatePicker.pinCenterX(to: wrap)
    }
    
    //MARK: - configure label for WishDescription
    private func configureWishDescriptionLabel() {
        wishDescriptionLabel.text = "Add description"
        wishDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        wishDescriptionLabel.textColor = randomColor //.black
        wishDescriptionLabel.textAlignment = .center
        
        wrap.addSubview(wishDescriptionLabel)
        wishDescriptionLabel.pinCenterX(to: wrap)
        wishDescriptionLabel.pinTop(to: endDatePicker.bottomAnchor, 20)
    }
    
    //MARK: - configure textField for wishDescription
    private func configureWishDescriptionTextField() {
        wishDescriptionTextField.placeholder = "Your description"
        wishDescriptionTextField.textAlignment = .center

        wrap.addSubview(wishDescriptionTextField)
        wishDescriptionTextField.pinTop(to: wishDescriptionLabel.bottomAnchor, -30)
        wishDescriptionTextField.pinHorizontal(to: wrap, 20)
        wishDescriptionTextField.setHeight(100)
    }
    
    //MARK: - configure warning label
    private func configureWarningLabel() {
        warningLabel.text = ""
        warningLabel.font = UIFont.boldSystemFont(ofSize: 15)
        warningLabel.textColor = randomColor //.black
        warningLabel.textAlignment = .center
        
        view.addSubview(warningLabel)
        warningLabel.pinCenterX(to: wrap)
        warningLabel.pinBottom(to: continueButton.topAnchor, 10)
    }
    
    //MARK: - configure continueButton
    private func configureContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = randomColor
        continueButton.layer.cornerRadius = 20
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.setHeight(50)
        continueButton.setWidth(250)
        continueButton.pinCenterX(to: view)
        continueButton.pinBottom(to: view.bottomAnchor, 40)
    }
    
    
    //MARK: - Continue button was pressed
    @objc
    private func continueButtonPressed() {
        dismiss(animated: true)
    }
    
    //MARK: - function for comparing dates
    private func compareDates() -> Bool {
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        
        let comparisonResult = startDate.compare(endDate)
        
        if (comparisonResult != .orderedSame && comparisonResult == .orderedAscending) {
            return true
        }
        return false
        
//        if comparisonResult == .orderedAscending {
//            print("Date 1 is earlier than Date 2")
//            return true
//        } else if comparisonResult == .orderedDescending {
//            print("Date 1 is later than Date 2")
//            return false
//        } else {
//            print("Date 1 is equal to Date 2")
//            return true
//        }
    }
}
    
//MARK: - generating random color method
private func generateRandomColor() -> UIColor {
    return UIColor(
        red: .random(in: Constants.colorMin...Constants.colorMax),
        green: .random(in: Constants.colorMin...Constants.colorMax),
        blue: .random(in: Constants.colorMin...Constants.colorMax),
        alpha: Constants.alphaValue
    )
}
