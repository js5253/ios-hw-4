//
//  LocationManager.swift
//  iOSHW4
//
//  Created by jose on 6/5/26.
//
import Foundation
import CoreLocation
internal import Combine
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    var status: CLAuthorizationStatus = .notDetermined;
    var manager: CLLocationManager?
    @Published var location: CLLocationCoordinate2D?
    @Published var heading: CLHeading?
    @Published var servicesOn = false
    @Published var updatesEnabled: Bool = false
    @Published var headingEnabled: Bool = false

    override init() {
        super.init()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status;
    }
    func checkIfLocationServicesIsEnabled() {
        if (CLLocationManager.locationServicesEnabled()) {
            manager = CLLocationManager()
            manager!.desiredAccuracy = kCLLocationAccuracyBest
            manager!.delegate = self
            servicesOn = true
            manager!.startUpdatingLocation()
            manager!.startUpdatingHeading()

        } else {
            print("Location Services Disablred.")
        }
        }
    func enableUpdates() {
        checkAuth()
        if (servicesOn) {
            manager?.startUpdatingLocation()
            
        }
        
    }
    func enableHeading() {
        checkAuth()
        if (servicesOn) {
            manager?.startUpdatingHeading()
            
        }
        
    }
    func disableHeading() {
        manager?.stopUpdatingHeading()

    }
    func disableUpdates() {
        manager?.stopUpdatingLocation()
        updatesEnabled = false
    }
        func requestLocation() {
            manager?.requestWhenInUseAuthorization()
        }
        private func checkAuth() {
            guard let manager = manager else {
                return
            }
            switch(manager.authorizationStatus) {
            case .authorizedAlways, .authorizedWhenInUse:
                print("yay :D")
                updatesEnabled = true
                
            default:
                print(";-;")
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            location = locations.first?.coordinate
        }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print(newHeading)
        heading = newHeading
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuth()
    }   
    }
