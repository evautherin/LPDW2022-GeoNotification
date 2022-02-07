//
//  ViewModel.swift
//  Notification
//
//  Created by Etienne Vautherin on 04/02/2022.
//

import Foundation
import Combine
import SwiftUI
import MapKit


class ViewModel: ObservableObject {
    @Published var userCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        latitudinalMeters: 500.0,
        longitudinalMeters: 500.0
    )
    @Published var notificationCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        latitudinalMeters: 500.0,
        longitudinalMeters: 500.0
    )
    @Published var name: String = "Default identifier"
    @Published var meter = 150.0
    
    func synchronizeNotificationMap() {
        notificationCoordinateRegion = userCoordinateRegion
    }
}
