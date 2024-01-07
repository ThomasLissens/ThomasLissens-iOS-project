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
        NavigationStack(path: $routerManager.routes) {
            NavigationBar()
        }

    }
}

#Preview {
    ContentView()
}
