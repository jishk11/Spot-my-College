//
//  LocationDetail.swift
//  College Lists
//
//  Created by Jishan Kharbanda on 8/10/22.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x:0, y:10)
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    statsSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
        
}


struct LocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationDetailView(location: LocationsDataService.locations.first!)
                .environmentObject(LocationsViewModel())
        }
    }
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        HStack(alignment: .center, spacing: 30) {
            VStack(alignment: .leading, spacing: 8) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(location.cityName + ", " + location.countryName)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical,30)
            
            VStack(alignment: .center){
                Text("Overall Rating " )
                    //.font(.headline)
                    .font(.system(size: 18.0))
                    .fontWeight(.bold)
                Image(systemName: location.sfSymbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.green)
                    .cornerRadius(36)
            }
        }
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
                Text("Popular Majors: " + location.popularmajors)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                
                Text("Acceptance Rate: " + location.acceptanceRate)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            Text("SAT Range (25% to 75%): " + location.satRange)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            Text("ACT Range (25% to 75%): " + location.actRange)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            Text("Average Tuition and Fees: " + location.tuition)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
        }
    }
    
    private var descriptionSection: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(location.description)
                    .font(.system(size: 14.0))
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                
                if let url = URL(string: location.link) {
                    Link("Continue Reading ➚", destination: url)
                        .font(.system(size: 18.0))
                        .tint(Color.blue)
                }
                if let url2 = URL(string: location.link2) {
                    Link("Learn more on " + location.schoolName + "'s website ➚", destination: url2)
                        .font(.system(size: 18.0))
                        .tint(Color.blue)
                }
                if let url3 = URL(string: location.link3) {
                    Link("Apply ➚", destination: url3)
                        .font(.headline)
                        .tint(Color.blue)
                }
        }
    }
    
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark.circle")
                .font(.system(size: 35, weight: .bold))
                .padding(16)
                .foregroundColor(Color.red)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}

