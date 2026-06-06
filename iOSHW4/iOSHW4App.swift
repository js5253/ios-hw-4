//
//  iOSHW4App.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI

@main
struct iOSHW4App: App {
    var locationManager = LocationManager.shared
    var calendarManager = CalendarManager.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(locationManager)
                    .environmentObject(calendarManager)

            }
        }
    }
}
