//
//  ContentView.swift
//  ios-project
//
//  Created by Thomas Lissens on 01/01/2024.
//

import SwiftUI


import Foundation
import SwiftUI

struct ApplicationView: View {
    @StateObject private var routerManager = NavigationRouter()

    var body: some View {
        TabView {
            NavigationView {
                HomeScreen()
                    .environmentObject(routerManager)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationView {
                StatsView()
                    .environmentObject(routerManager)
            }
            .tabItem {
                Label("Stats", systemImage: "gearshape")
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct Application_Preview: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
