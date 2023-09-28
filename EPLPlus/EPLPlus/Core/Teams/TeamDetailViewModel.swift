//
//  TeamDetailViewModel.swift
//  EPLPlus
//
//  Created by Cooper Jacob on 28/9/2023.
//

import Foundation
import MapKit
import CoreLocation


final class TeamDetailViewModel: BaseViewModel {
    @Published var mapRegion: MKCoordinateRegion =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3555, longitude: 1.1743), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
}
