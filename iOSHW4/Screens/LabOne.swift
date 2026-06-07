//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI
internal import _LocationEssentials

struct LabOne: View {
    @StateObject private var locationManager = LocationManager.shared

    @State var selectedPrecision: Int = 0
    var body: some View {
        if (locationManager.location != nil) {
            List {
                Text("Enabled Location Services: \(locationManager.servicesOn ? "Yes" : "No")")
                Text("Enabled Location Updates: \(locationManager.updatesEnabled ? "Yes" : "No")")
                Text(String(locationManager.location!.latitude))
                Text(String(locationManager.location!.longitude))
                    Picker("Precision", selection: $selectedPrecision) {
                        Text("IDK").tag(0)
                    }
                        .pickerStyle(.segmented)
                Toggle("Location Updates", isOn: $locationManager.updatesEnabled)
                    .onChange(of: locationManager.updatesEnabled, {
                        oldVal, newVal in
                        if (newVal) {
                            locationManager.enableUpdates()
                        } else {
                            locationManager.disableUpdates()

                        }
                    })

            }
            
        } else {
            Text("No Location")
        }
    }
}

#Preview {
    LabOne()
}
