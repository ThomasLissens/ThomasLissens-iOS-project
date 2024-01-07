//
//  NavigationBar.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

struct NavigationBar: View {
    @StateObject private var routerManager = NavigationRouter()

    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            TabView {

                HomeScreen()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "gearshape")
                    }
            }
        }
    }
}


struct NaviagtionBar_Preview: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
