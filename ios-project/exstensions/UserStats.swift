//
//  UserStats.swift
//  ios-project
//
//  Created by Thomas Lissens on 06/01/2024.
//

import Foundation

extension UserDefaults {
    func stats(forKey key: String) -> Stats {
        if let jsonData = data(forKey: key),
           let decodedStats = try? JSONDecoder().decode(Stats.self, from: jsonData) {
            return decodedStats
        } else {
            return Stats()
        }
    }
    func set(_ stats: Stats, forKey key: String) {
        let data = try? JSONEncoder().encode(stats)
        set(data, forKey: key)
    }
}
