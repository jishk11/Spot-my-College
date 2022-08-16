//
//  LocationPreviewView.swift
//  College Lists
//
//  Created by Jishan Kharbanda on 8/10/22.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
                VStack(alignment: .leading) {
                   // statsSection
                    learnmoreButton
                    nextButton
                    backButton
            }
        }
        .padding(20)
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(20)
    }
}
    
struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .padding() 
        }
        .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(location.name)
       
                    .fontWeight(.bold)
                Text(location.cityName + ", " + location.countryName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var statsSection: some View {
        HStack(alignment: .center){
        Text("Overall Rating ")
                //.font(.headline)
                .font(.system(size: 16.0))
                .fontWeight(.bold)
        Image(systemName: "a.circle.fill")
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
    
    private var learnmoreButton: some View {
        Button{
            vm.sheetLocation = location
        }
    label: {
        Text("Learn more")
            .font(.headline)
            .frame(width: 112, height: 27)
        }
        .buttonStyle(.borderedProminent)
        .cornerRadius(15)
    
    }
    
    private var nextButton: some View {
        Button{
            vm.nextButtonPressed()
        }
        label: {
                Text("Next")
                    .font(.headline)
                    .frame(width: 112, height: 27)
                    }
            .buttonStyle(.bordered)
            .cornerRadius(15)
    }
    private var backButton: some View {
        Button{
            vm.backButtonPressed()
        }
        label: {
                Text("Back")
                    .font(.headline)
                    .frame(width: 112, height: 27)
                    }
            .buttonStyle(.bordered)
            .cornerRadius(15)
    }
}
