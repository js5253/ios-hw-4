//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI

struct LabTwo: View {
    @StateObject private var locationManager = LocationManager.shared
    @State var selectedPrecision: Int = 0
    var body: some View {
        List {
            Text("Enabled Location Services: \(locationManager.servicesOn ? "Yes" : "No")")
            Text("Geographic Heading On: \(locationManager.headingEnabled ? "Yes" : "No")")
            Text("Heading: \(locationManager.heading)")

            Toggle("Location Updates", isOn: $locationManager.updatesEnabled)
                .onChange(of: locationManager.updatesEnabled, {
                    oldVal, newVal in
                    if (newVal) {
                        LocationManager.shared.enableUpdates()
                    } else {
                        LocationManager.shared.disableUpdates()

                    }
                })
            Toggle("Geographic Heading Updates", isOn: $locationManager.headingEnabled)
                .onChange(of: locationManager.headingEnabled, {
                    oldVal, newVal in
                    if (newVal) {
                        locationManager.enableHeading()
                    } else {
                        locationManager.disableHeading()

                    }
                })

        }
    }
}

#Preview {
    LabTwo()
}
