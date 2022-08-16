//
//  College_ListsApp.swift
//  College Lists
//
//  Created by Jishan Kharbanda on 8/9/22.
//

import SwiftUI
 
@main
struct College_ListsApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                LocationsView()
                    .environmentObject(vm)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Explore")
                    }
                    TipsView()
                    .tabItem {
                        Image(systemName: "info.circle.fill")
                        Text("About")
                        
                    }
            }
        }
    }
}
