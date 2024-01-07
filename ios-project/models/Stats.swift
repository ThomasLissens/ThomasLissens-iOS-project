//
//  Stats.swift
//  ios-project
//
//  Created by Thomas Lissens on 06/01/2024.
//

import Foundation

struct Stats: Identifiable, Codable, Hashable {
    var points: Int = 0
    var gamesWon: Int = 0
    var id = UUID()
}
