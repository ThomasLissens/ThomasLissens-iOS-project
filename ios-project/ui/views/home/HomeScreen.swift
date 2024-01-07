//
//  HomeScreen.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var routeManager: NavigationRouter
    @StateObject var game = LevelSelectionViewModel()
    
    var body: some View {
        VStack {
            NavigationStack(path: $routeManager.routes) {
            
                Title(title: "Guessery")
            
                NavigationLink(value: Route.levelSelect(viewmodel: game)) {
                    Text("Play")
                }.navigationDestination(for: Route.self) { $0 }
            }
        }
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(game: LevelSelectionViewModel())
    }
}

