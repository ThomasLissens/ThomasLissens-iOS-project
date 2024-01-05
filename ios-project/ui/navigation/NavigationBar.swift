//
//  NavigationBar.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

struct NaviagtionBar: View {
    @StateObject private var routerManager = NavigationRouter()

    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            TabView {

                HomeScreen()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Stats", systemImage: "gearshape")
                    }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        HStack {
            Text("Yow")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        HStack {
            Text("Settings")
        }
    }
}

struct NaviagtionBar_Preview: PreviewProvider {
    static var previews: some View {
        NaviagtionBar()
    }
}
