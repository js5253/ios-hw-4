//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: LocationManager
    var body: some View {
        List {
            Button(action: {
                LocationManager.shared.requestLocation()
            }) {
                Text("Ask for Permission")
            }.disabled(manager.servicesOn)
            Group {
                NavigationLink("Lab1") {
                    LabOne()
                }
                NavigationLink("Lab2") {
                    LabTwo()
                }
            }.disabled(!manager.servicesOn)

            NavigationLink("Calendar Events") {
                AdditionalScreen()
            }

        }
        .onAppear {
            manager.checkIfLocationServicesIsEnabled()
        }
    }
}

#Preview {
    ContentView()
}
