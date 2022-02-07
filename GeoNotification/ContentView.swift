//
//  ContentView.swift
//  GeoNotification
//
//  Created by Etienne Vautherin on 07/02/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @StateObject var model = ViewModel()
    
    var body: some View {
        Map(
            coordinateRegion: $model.userCoordinateRegion,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow)
        ).onAppear(perform: {
            CLLocationManager().requestWhenInUseAuthorization()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
