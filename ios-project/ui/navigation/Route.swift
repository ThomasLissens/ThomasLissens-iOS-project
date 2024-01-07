//
//  Routes.swift
//  ios-project
//
//  Created by Thomas Lissens on 04/01/2024.
//

import Foundation
import SwiftUI

enum Route {
    case home
    case stats
    case levelSelect(viewmodel: LevelSelectionViewModel)
    case game(levelObject: LevelObject)
}

extension Route: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        case (.stats, .stats):
            return true
        case (.levelSelect, .levelSelect):
            return true
        case (.game, .game):
            return true
    
        default:
            return false
        }
    }
}

extension Route: View {
    var body: some View {
        switch self {
        case .home:
            ApplicationView()
        case .stats:
            StatsView()
        case .levelSelect(let vm):
            LevelSelectionView(viewModel: vm)
        case .game(let levelObject):
            GameView(levelObject: levelObject)
        }
    }
}
