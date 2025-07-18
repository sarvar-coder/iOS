//
//  RequestLocationView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 18/07/25.
//

import SwiftUI
import CoreLocationUI

struct RequestLocationView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            
            Image("creature_dog-and-bone")
                .resizable()
                .frame(width: 240, height: 240)
            
            Text("""
        To find pets near you, first, you need to
        share your current location.
        """)
            .multilineTextAlignment(.center)
            
            LocationButton {
                locationManager.requestWhenInUseAuthorization()
            }
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            
            locationManager.updateAuthorizationStatus()
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

#Preview {
    RequestLocationView()
        .environmentObject(LocationManager())
}
