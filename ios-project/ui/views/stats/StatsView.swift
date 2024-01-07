//
//  StatsView.swift
//  ios-project
//
//  Created by Thomas Lissens on 06/01/2024.
//

import Foundation
import SwiftUI

struct StatsView: View {
    @ObservedObject var statsViewModel: StatsViewModel = StatsViewModel()
    
    var body: some View {
        VStack {
            Title(title: "Stats")
            Text("Points: " + statsViewModel.stats.points.description)
            Text("Games won: " + statsViewModel.stats.gamesWon.description)
        }
    }
}
