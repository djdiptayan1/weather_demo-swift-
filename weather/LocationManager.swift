//
//  LocationManager.swift
//  weather
//
//  Created by Diptayan Jash on 19/12/23.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location: CLLocation?
    @Published var placemark: CLPlacemark?

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        geocode()
    }

    private func geocode() {
        guard let location = location else { return }
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error)")
                return
            }
            self.placemark = placemarks?.first
        }
    }
}
