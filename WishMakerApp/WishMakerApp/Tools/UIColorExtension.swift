//
//  UIColorExtension.swift
//  WishMakerApp
//
//  Created by Данила Рахманов on 05.02.2024.
//

import Foundation
import UIKit

//MARK: - extension for generating random
extension UIColor {
    static func generateRandomColor() -> UIColor {
        return UIColor(
            red: .random(in: Constants.colorMin...Constants.colorMax),
            green: .random(in: Constants.colorMin...Constants.colorMax),
            blue: .random(in: Constants.colorMin...Constants.colorMax),
            alpha: Constants.alphaValue
        )
    }
}
