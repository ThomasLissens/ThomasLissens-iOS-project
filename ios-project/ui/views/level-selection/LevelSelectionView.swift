//
//  LevelSelectionScreen.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

struct LevelSelectionView: View {
    @EnvironmentObject private var routeManager: NavigationRouter
    @ObservedObject var viewModel: LevelSelectionViewModel
    
    var body: some View {

        VStack {
                
                if viewModel.hasError && viewModel.levelList.isEmpty {
                    Text("Error: \(viewModel.error?.errorDescription ?? "Unknown error")")
                } else if !viewModel.levelList.isEmpty {
                    List(viewModel.levelList, id: \.category) { levelObject in
                        NavigationLink(value: Route.game(levelObject: levelObject) ) {
                            Text(levelObject.level)
                        }
                    }
                    .navigationTitle("Level selection")
                } else {
                    ProgressView("Fetching Levels...")
                }

            }.toolbar(.hidden, for: .tabBar)
        
    
    }
}

struct LevelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectionView(viewModel: LevelSelectionViewModel())
    }
}
