//
//  CalendarManager.swift
//  WishMakerApp
//
//  Created by Данила Рахманов on 06.02.2024.
//

import Foundation
import EventKit

final class CalendarManager: CalendarManaging {
    
    //MARK: - fields
    private let eventStore : EKEventStore = EKEventStore()
    
    //MARK: - function for creating an event in user's calendar
    func create(eventModel: CalendarEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        group.enter()
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        group.wait()
        return result
    }
    
    func create(eventModel: CalendarEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted,
                                                                                     error) in
            guard granted, error == nil, let self else {
                completion?(false)
                return
            }
            let event: EKEvent = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            do {
                try self.eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
                print("failed to save event with error : \(error)")
                completion?(false)
            }
            completion?(true)
        }
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents(completion: createEvent)
        } else {
            eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}
