//
//  Constants.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 31.10.2023.
//

import UIKit

//MARK: - constants enum
enum Constants {
    static let sliderTitleFontSize: CGFloat = 17
    static let sliderTitleTopAnchor: CGFloat = 15
    
    static let sliderCenterXAnchor: CGFloat = -10
    
    static let sliderLeadingAnchor: CGFloat = 25
    
    static let viewColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    
    static let colorMin: Double = 0
    static let colorMax: Double = 1
    static let alphaValue: Double = 1
    
    static let red: String = "Red"
    static let green: String = "Green"
    static let blue: String = "Blue"
    
    static let redComponent: Int = 0
    static let greenComponent: Int = 1
    static let blueComponent: Int = 2
    static let defaultComponent: CGFloat = 0
    
    static let buttonsTitleFontSize: CGFloat = 17
    static let buttonsCornerRadius: CGFloat = 20
    static let buttonsHeightAnchor: CGFloat = 45
    static let buttonsViewBottomAnchor: CGFloat = 30
    static let buttonsBottomAnchor: CGFloat = 5
    
    static let previousColorButtonTitle: String = "Set previous random color"
    static let hideButtonTitle: String = "Hide sliders"
    static let randomColorButtonTitle: String = "Set random color"
    static let colorPickerButtonTitle: String = "Use iOS color picker"
    static let showWishButtonTitle: String = "My wishes"
    static let ScheduleWishButtonTitle: String = "Schedule wishes"
    static let addWishButtonTitle: String = "Add a wish!"
    static let editWishButtonTitle: String = "Edit a wish!"
    static let clearTableButtonTitle: String = "Clear Table"
    
    static let leadingAnchor: CGFloat = 20
    
    static let defaultColorDescriptionLabelText: String = "Tap the color to copy it"
    static let defaultColorLabelText: String = "#FFFFFF"
    static let colorDescriptionLabelFontSize: CGFloat = 12
    static let colorLabelFontSize: CGFloat = 16
    static let colorDescriptionTopAnchor: CGFloat = 2
    static let colorLabelFormat: String = "#%02lX%02lX%02lX"
    
    static let maxColorNumber: CGFloat = 255
    
    static let title: String = "WishMaker"
    static let titleFontSize: CGFloat = 32
    static let titleTopAnchor: CGFloat = -35
    
    static let wishTextFieldTopAnchor: CGFloat = 15
    static let defaultPreviousColor: UIColor = .black
    
    static let description: String =
    """
    This small app can lift your spirits and fulfill three of your wishes!
        · You are able to change background color
        · Write, Edit and Delete your wishes in table
    
    To be continued...
    """
    static let descriptionNumberOfLines: Int = 0
    static let descriptionFontSize: CGFloat = 15
    static let descriptionTopAnchor: CGFloat = 10
    
    static let slidersCornerRadius: Double = 25
    static let slidersBottomAnchor: CGFloat = 5
    
    static let randomColorAnimationDur: Double = 0.3
    static let colorPickerAnimationDur: Double = 0.5
    
    static let wrapColor: UIColor = Constants.viewColor
    static let wrapRadius: CGFloat = 17
    static let wrapOffsetV: CGFloat = 5
    static let wrapOffsetH: CGFloat = 10
    static let wishLabelOffset: CGFloat = 10
    
    static let wishArrayKey: String = "wishArray"
    
    static let defaultWishTextField: String = ""
    static let editWishTextFieldPlaceholder: String = "Edit your wish here!"
    static let addWishTextFieldPlaceholder: String = "Type your wish here!"
    
    static let tableCornerRadius: CGFloat = 25
    static let tableTopAnchor: CGFloat = 5
    static let tableBottomAnchor: CGFloat = 0
    static let tableHOffset: CGFloat = 10
    
    static let wrapHOffset: CGFloat = 10
    static let wrapTopAnchor: CGFloat = 15
    
    static let wishCellReuseId: String = "WrittenWishCell"
    static let wishCellError: String = "init(coder:) has not been implemented"
    
    static let wishDeleteButtonRightAnchor: CGFloat = 10
    static let wishEditButtonRightAnchor: CGFloat = 5
    
    static let wishDeleteIcon: String = "minus.circle.fill"
    static let wishEditIcon: String = "pencil.circle.fill"
    
    static let wishLabelLeftAnchor: CGFloat = 10
    static let wishLabelRightAnchor: CGFloat = 50
    
    static let defaultEditingRowFlag: Int = -1
}
