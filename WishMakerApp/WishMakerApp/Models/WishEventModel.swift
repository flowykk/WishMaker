//
//  WishEventModel.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import Foundation

class WishEventModel {
    var wishTitle: String
    var description: String
    var startDate: String
    var endDate: String
    
    init(wishTitle: String, description: String, startDate: String, endDate: String) {
        self.wishTitle = wishTitle
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}
