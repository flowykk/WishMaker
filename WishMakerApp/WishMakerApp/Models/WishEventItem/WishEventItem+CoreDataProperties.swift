//
//  WishEventItem+CoreDataProperties.swift
//  WishMakerApp
//
//  Created by Данила Рахманов on 05.02.2024.
//
//

import Foundation
import CoreData


extension WishEventItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishEventItem> {
        return NSFetchRequest<WishEventItem>(entityName: "WishEventItem")
    }

    @NSManaged public var wishEventTitle: String?
    @NSManaged public var wishEventDescription: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?

}

extension WishEventItem : Identifiable {

}
