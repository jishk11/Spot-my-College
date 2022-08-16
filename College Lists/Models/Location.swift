//
//  Location.swift
//  College Lists
//
//  Created by Jishan Kharbanda on 8/9/22.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let name: String
    let schoolName: String
    let cityName: String
    let countryName: String
    let coordinates: CLLocationCoordinate2D
    let popularmajors: String
    let acceptanceRate: String
    let satRange: String
    let actRange: String
    let tuition: String
    let sfSymbol: String
    let description: String
    let imageNames: [String]
    let link: String
    let link2: String
    let link3: String
    
    var id: String {
        name + cityName + countryName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    

}
