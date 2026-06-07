//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI
import EventKit

struct AdditionalDetailScreen: View {
    @Environment(\.editMode) private var editMode
    @StateObject var calendarManager = CalendarManager.shared

    var event: EKEvent
    @State var eventTitle = ""
    init(event: EKEvent) {
        eventTitle = event.title
        self.event = event
    }
    var body: some View {
        NavigationView {
            List {
                if (editMode?.wrappedValue.isEditing == true) {
                    TextField("Edit item", text: $eventTitle)
                        .textFieldStyle(.roundedBorder)
                } else {
                    Text(eventTitle).font(.title)

                }
                if (event.startDate != nil) {
                    Text("From \(event.startDate!)")
                }
                if (event.endDate != nil) {
                    Text("To \(event.endDate!)")
                }
                Text(event.organizer?.name ?? "No Organizer")
                Text("Identifier: \(event.id)").font(.caption2)
                
                
            }
            
        }.toolbar {
            EditButton()
                
        }
        .onChange(of: editMode?.wrappedValue, {
            event.title = eventTitle
            calendarManager.saveItemTitle(event: event);
        })
    }
        
}
struct AdditionalScreen: View {
    @StateObject var calendarManager = CalendarManager.shared
    
    var body: some View {
        Group {
            if (calendarManager.isLoading) {
                ProgressView()
            } else if (!calendarManager.hasPermission) {
            Text("Permissions were not given to fetch calendar events. Check your settings and restart the app.")
        } else {
            List {
                Button(action: {
                    try? calendarManager.getTodaysEvents()
                }) {
                    Text("Get Events")
                }
                ForEach(calendarManager.events) { event in
                    NavigationLink(event.title) {
                        AdditionalDetailScreen(event: event)
                    }
                }
            }
            
        }
        }
        .onAppear {
            try? calendarManager.getTodaysEvents()
        }
    }
}

#Preview {
    AdditionalScreen()
}
