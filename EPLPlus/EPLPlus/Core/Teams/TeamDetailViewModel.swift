//
//  TeamDetailViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 28/9/2023.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI


final class TeamDetailViewModel: BaseViewModel {
    
    let address: String
    
    init(address: String) {
        self.address = address
        super.init()
        centerOnAddress()
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.3555, longitude: -1.1743),
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
    )
    
    func centerOnAddress() {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address
        
        let addressSearch = MKLocalSearch(request: searchRequest)
        
        addressSearch.start { response, error in
            guard let response = response else {
                print("Could not complete address search: \(String(describing: error?.localizedDescription))")
                return
            }
            var region = response.boundingRegion
            
            let zoomFactor: Double = 0.7 // adjust this value as needed
            region.span.latitudeDelta *= zoomFactor
            region.span.longitudeDelta *= zoomFactor
            
            self.mapRegion = region
        }
        
    }
}
