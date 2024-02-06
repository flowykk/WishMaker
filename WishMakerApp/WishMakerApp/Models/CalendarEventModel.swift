//
//  CalendarEventModel.swift
//  WishMakerApp
//
//  Created by Данила Рахманов on 06.02.2024.
//

import Foundation
import EventKit

protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}

struct CalendarEventModel {
    var title: String
    var startDate: Date
    var endDate: Date
}
