//
//  HomeScreen.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    @State private var path: [String] = []
    
    var body: some View {
            NavigationStack(path: $path) {
                Button("Level selection") {
                    path.append("Level selection")
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: String.self) { value in
                if value == "Level selection" {
                    LevelSelectionView()
                }
            }
        }
}


