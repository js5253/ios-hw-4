//
//  CalendarManager.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//
enum AppError: Error {
    case noPermissions
}

import EventKit
internal import Combine
final class CalendarManager: ObservableObject {
    static var shared = CalendarManager()
    @Published var hasPermission = false
    @Published var isLoading = true
    @Published var events: [EKEvent] = []
    var store = EKEventStore()
    private init() {
    }
    func getTodaysEvents() throws {
            Task {
                try await requestAccess()
                isLoading = false
                if (!hasPermission) {
                    throw AppError.noPermissions
                }
                let calendars = [store.defaultCalendarForNewEvents!]
                
                let startDate = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
                let endDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
                events = store.events(matching: store.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars))
            }
    }
    func saveItemTitle(event: EKEvent) {
        print("Saving...")
        do {
            try store.save(event, span: .thisEvent)
            try getTodaysEvents();
        } catch {
            ErrorService.shared.handleError(description: error)
        }
        
    }
    func requestAccess() async throws {
        // Request access to reminders.
        do {
            try await store.requestFullAccessToEvents()
            hasPermission = true
        } catch {
            hasPermission = false
            ErrorService.shared.handleError(description: error)
            throw error
        }
    }
}

extension EKEvent: Identifiable {
    public var id: String { title }
}
