//
//  DateExtension.swift
//  WishMakerApp
//
//  Created by Данила Рахманов on 05.02.2024.
//

import Foundation

//MARK: - extension for removing Time from Date
extension Date {
    public var removeTimeFromDate : String {
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
   }
}
