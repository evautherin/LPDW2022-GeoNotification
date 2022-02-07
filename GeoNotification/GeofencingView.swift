//
//  SettingsView.swift
//  Location
//
//  Created by Etienne Vautherin on 03/02/2022.
//

import SwiftUI
import MapKit

struct GeofencingView: View {
    @ObservedObject var model: ViewModel
    
    var body: some View {
        VStack{
            ZStack(alignment: .topTrailing) {
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
                
                Button {
                    model.isEditing = false
                } label: {
                    Image(systemName: "xmark.circle")
                }
                .buttonStyle(.borderedProminent)
                .padding()

            }
            TextField("Name of your region", text: $model.name)
            Text("Meter: \(Int(model.meter))")
            Slider(value: $model.meter, in: 50...250, step: 10)
        }
        .padding()
        .onAppear(perform: {
            model.synchronizeNotificationMap()
        })
        .onDisappear(perform: {
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeofencingView(model: ViewModel()).environmentObject(ViewModel())
    }
}

