//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI
import EventKit

struct AdditionalDetailScreen: View {
    var event: EKEvent
    var body: some View {
        List {
            Text(event.title).font(.title)
            Text("From \(event.startDate) to \(event.endDate)")
            Text(event.organizer?.name ?? "No Organizer")
            Text("Identifier: \(event.id)").font(.caption2)
            
        }
    }
}
struct AdditionalScreen: View {
    @EnvironmentObject var calendarManager: CalendarManager

    var store = EKEventStore();
    
    var body: some View {
        List {
            Button(action: {
                
                CalendarManager.shared.getTodaysEvents()
            }) {
                Text("Get Events")
            }
            ForEach(CalendarManager.shared.events) { event in
                NavigationLink(event.title) {
                    AdditionalDetailScreen(event: event)
                }
            }
        }
    }
}

#Preview {
    AdditionalScreen()
}
