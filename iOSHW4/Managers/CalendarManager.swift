//
//  CalendarManager.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//
import EventKit
internal import Combine
final class CalendarManager: ObservableObject {
    static var shared = CalendarManager()
    @Published var hasPermission = false
    @Published var events: [EKEvent] = []
    var store = EKEventStore()
    init() {
    }
    func getTodaysEvents() {
        Task {
            if (!hasPermission) {
                await requestAccess()
            }
    //        guard let store = store else {return}
            let calendars = [store.defaultCalendarForNewEvents!]
            
            let startDate = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
            let endDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
            events = store.events(matching: store.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars))
            
            print(events)

        }
    }
    func requestAccess() async {
        // Request access to reminders.
        do {
            try await store.requestFullAccessToEvents()
        } catch {
            print("ERROR REQUESTING ACCESS TO EVENTS")
        }
    }
}

extension EKEvent: Identifiable {
    public var id: String { title }
}
