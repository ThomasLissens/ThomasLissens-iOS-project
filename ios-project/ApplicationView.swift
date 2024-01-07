//
//  ContentView.swift
//  ios-project
//
//  Created by Thomas Lissens on 01/01/2024.
//

import SwiftUI

struct ContentView: View {
    
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
            }.navigationViewStyle(StackNavigationViewStyle()) // Use this to make sure the NavigationView style is set to StackNavigationViewStyle

        }

    }
}

#Preview {
    ContentView()
}
