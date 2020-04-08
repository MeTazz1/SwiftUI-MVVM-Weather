//
//  DetailsMapView.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import SwiftUI
import MapKit

extension DetailsView {
     
    struct MapView: UIViewRepresentable {

        let latitude: Double
        let longitude: Double
        
        func makeUIView(context: Context) -> MKMapView {
             MKMapView(frame: .zero)
         }
         
         func updateUIView(_ view: MKMapView, context: Context) {
             
            let span = MKCoordinateSpan(latitudeDelta: 0.13, longitudeDelta: 0.13)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: span)
             view.setRegion(region, animated: true)
         }
    }
}


struct DetailsMapView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView.MapView(latitude: 48.8674, longitude: 2.3458)
    }
}
