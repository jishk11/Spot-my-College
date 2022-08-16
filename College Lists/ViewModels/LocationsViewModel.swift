//
//  LocationsViewModel.swift
//  College Lists
//
//  Created by Jishan Kharbanda on 8/9/22.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    //All of the loaded locations
    @Published var locations: [Location]
    
    //The current location on the map
    @Published var mapLocation: Location {
    didSet {
        updateMapRegion(location: mapLocation)
        }
    }
    
    //The current region on the map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show the list of locations
    @Published var showLocationsList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion (
            center: location.coordinates,
            span: mapSpan)
            }
    }
        func toggleLocationsList() {
            withAnimation(.easeInOut){
                showLocationsList = !showLocationsList
            }
        }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
        
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array.")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            
            guard  let firstLocation = locations.first else {
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    func backButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array.")
            return
        }
        
        let backIndex = currentIndex - 1
        guard locations.indices.contains(backIndex) else {
            
            guard  let firstLocation2 = locations.last else {
                return
            }
            showNextLocation(location: firstLocation2)
            return
        }
        
        let nextLocation = locations[backIndex]
        showNextLocation(location: nextLocation)
    }
}

    

