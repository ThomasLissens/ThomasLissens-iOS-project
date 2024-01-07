//
//  StatsViewModel.swift
//  ios-project
//
//  Created by Thomas Lissens on 06/01/2024.
//

import Foundation

final class StatsViewModel: ObservableObject {
    private let userDefaultsKey = DbRoutes.userDefaultsKey
    
    var stats: Stats {
        get {
            UserDefaults.standard.stats(forKey: userDefaultsKey)
        }
        set {
            if (newValue.hashValue == 0) {
                UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                objectWillChange.send()
            }
        }
    }
}
