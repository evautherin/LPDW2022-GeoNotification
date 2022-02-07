//
//  SettingsView.swift
//  Location
//
//  Created by Etienne Vautherin on 03/02/2022.
//

import SwiftUI
import MapKit

struct GeofencingView: View {
    @StateObject var model = ViewModel()
        
    init(model: ViewModel) {
        model.synchronizeNotificationMap()
    }
    
    var body: some View {
        VStack{
            ZStack {
                Map(coordinateRegion: $model.notificationCoordinateRegion)
                Circle()
                    .strokeBorder(Color.white, lineWidth: 3)
                    .frame(width: 22.0, height: 22.0)
                Rectangle()
                    .frame(width: 22, height: 2, alignment: .center)
                Rectangle()
                    .frame(width: 2, height: 22, alignment: .center)
            }
            TextField("Name of your region", text: $model.name)
            Text("Meter: \(Int(model.meter))")
            Slider(value: $model.meter, in: 50...250, step: 10)
        }
        .padding()
        .onDisappear(perform: {
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeofencingView(model: ViewModel()).environmentObject(ViewModel())
    }
}

