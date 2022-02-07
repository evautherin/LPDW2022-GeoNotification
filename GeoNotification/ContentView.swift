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
                .onAppear(perform: {
                    CLLocationManager().requestWhenInUseAuthorization()
                })
                .sheet(isPresented: $isEditing) {
                    GeofencingView(model: model)
                }

            
                Button {
                    isEditing = true
                } label: {
//                    Image(systemName: isEditing ? "xmark.circle" : "circle.dashed")
                    Image(systemName: "circle.dashed")
                }
                .buttonStyle(.borderedProminent)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
