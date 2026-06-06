//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI
internal import _LocationEssentials

struct LabOne: View {
    @EnvironmentObject var locationManager: LocationManager
    @State var selectedPrecision: Int = 0
    @State var locationUpdatesOn: Bool = true
    var loc = LocationManager.shared.location
    var body: some View {
        if (loc != nil) {
            List {
                Text("Enabled Location Services: \(LocationManager.shared.servicesOn ? "Yes" : "No")")
                Text("Enabled Location Updates: \(LocationManager.shared.updatesEnabled ? "Yes" : "No")")
                Text(String(LocationManager.shared.location!.latitude))
                Text(String(LocationManager.shared.location!.longitude))
                    Picker("Precision", selection: $selectedPrecision) {
                        Text("IDK").tag(0)
                    }
                        .pickerStyle(.segmented)
                Toggle("Location Updates", isOn: $locationUpdatesOn)
                    .onChange(of: locationUpdatesOn, {
                        oldVal, newVal in
                        if (newVal == true) {
                            LocationManager.shared.enableUpdates()
                        } else {
                            LocationManager.shared.disableUpdates()

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
