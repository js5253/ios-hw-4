//
//  ContentView.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//

import SwiftUI

struct LabTwo: View {
    @State var selectedPrecision: Int = 0
    @State var headingUpdatesOn: Bool = true
    @State var locationUpdatesOn: Bool = true
    var body: some View {
        List {
            Text("Enabled Location Services: \(LocationManager.shared.servicesOn ? "Yes" : "No")")
            Text("Enabled Location Services: \(LocationManager.shared.headingEnabled ? "Yes" : "No")")
            Text("Heading: \(LocationManager.shared.heading)")

            Toggle("Location Updates", isOn: $locationUpdatesOn)
                .onChange(of: locationUpdatesOn, {
                    oldVal, newVal in
                    if (newVal == true) {
                        LocationManager.shared.enableUpdates()
                    } else {
                        LocationManager.shared.disableUpdates()

                    }
                })
            Toggle("Geographic Heading Updates", isOn: $headingUpdatesOn)
                .onChange(of: headingUpdatesOn, {
                    oldVal, newVal in
                    
                    if (newVal == true) {
                        LocationManager.shared.enableHeading()
                    } else {
                        LocationManager.shared.disableHeading()

                    }
                })

        }
    }
}

#Preview {
    LabTwo()
}
