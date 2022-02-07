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
    @State var isEditing = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
                Map(
                    coordinateRegion: $model.userCoordinateRegion,
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow)
                )
            
                Button {
                    isEditing = true
                } label: {
//                    Image(systemName: isEditing ? "xmark.circle" : "circle.dashed")
                    Image(systemName: "circle.dashed")
                }
                .buttonStyle(.borderedProminent)
                .padding()
        }
        .onAppear(perform: {
            CLLocationManager().requestWhenInUseAuthorization()
        })
        .sheet(isPresented: $isEditing) {
            GeofencingView(model: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
