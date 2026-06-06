//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI
import EventKit
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
            ForEach(calendarManager.events) { event in
                Text(event.title)
            }
        }
    }
}

#Preview {
    AdditionalScreen()
}
