//
//  NavigationRoutes.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    @Published var routes = [Route]()
    @Published var tabBarHidden: Bool = false

    
    func push(to screen: Route) {
        guard !routes.contains(screen) else {
            return
        }
        
        routes.append(screen)
    }
    
    func goBack() {
        _ = routes.popLast()
    }
        
    func reset() {
        routes = []
    }
}

public enum Visibility {
    case automatic
    case hidden
    case visible
}
