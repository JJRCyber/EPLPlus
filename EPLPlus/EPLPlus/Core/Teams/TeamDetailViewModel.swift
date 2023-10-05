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

// View model for team detail
// Inherits from base view model
// Initialises map region and searches for stadium address
final class TeamDetailViewModel: BaseViewModel {
    
    let address: String
    
    init(address: String) {
        self.address = address
        super.init()
        centerOnAddress()
    }
    
    // Sets map region to initial value of UK
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.3555, longitude: -1.1743),
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
    )
    
    // Uses MKLocalSearch to search for address of stadium
    // If address is found centers the mapRegion on the returned region
    func centerOnAddress() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address
        
        let addressSearch = MKLocalSearch(request: searchRequest)
        
        addressSearch.start { response, error in
            guard let response = response else {
                // If search is not succesfull print debugging message and leave map region as UK
                print("Could not complete address search: \(String(describing: error?.localizedDescription))")
                return
            }
            // If search succesful modify the zoom of the area and set mapRegion to returned region
            var region = response.boundingRegion
            let zoomFactor: Double = 0.7
            region.span.latitudeDelta *= zoomFactor
            region.span.longitudeDelta *= zoomFactor
            
            self.mapRegion = region
        }
        
    }
}
