//
//  GameView.swift
//  ios-project
//
//  Created by Thomas Lissens on 04/01/2024.
//

import Foundation
import SwiftUI
import Combine

struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @EnvironmentObject private var routeManager: NavigationRouter
    
    init(levelObject: LevelObject) {
        self.gameViewModel = GameViewModel(levelObject: levelObject)
    }
    
    var body: some View {
            Color(hex: 0x6650a4)
                .ignoresSafeArea()
                .overlay {
                    ScrollView {
                        VStack {
                            Title(title: gameViewModel.game.category)

                            ForEach(0..<gameViewModel.game.wordsList.count, id: \.self) { wordIndex in
                                    
                                    HStack() {
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 30, maximum: 100), spacing: 5)], spacing: 5) {
                                            ForEach(0..<gameViewModel.game.wordsList[wordIndex].letters.count, id: \.self) { letterIndex in
                                                if gameViewModel.shouldNotShowTextField(indexWord: wordIndex, indexLetter: letterIndex) {
                                                    Color.clear
                                                } else {
                                                    TextField("", text: $gameViewModel.game.wordsList[wordIndex].letters[letterIndex].max(1))
                                                        .onChange(of: gameViewModel.game.wordsList[wordIndex].letters[letterIndex], initial: true) {
                                                            gameViewModel.checkWord(wordIndex: wordIndex)
                                                        }
                                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                                        .frame(width: 30, height: 30)
                                                        .multilineTextAlignment(.center)
                                                        .padding(5)
                                                }
                                            }
                                        }
                                        .padding(5)
                                    }
                                    .background(correctWord(wordIndex: wordIndex))
                                    .disabled(gameViewModel.game.wordsList[wordIndex].correct)

                            }
                            .padding(.vertical, 5)
                            
                            gameComplete()
            
                        }
                        .padding()
                    }
                }
        
        .toolbar(.hidden, for: .navigationBar)
    }

    func correctWord(wordIndex: Int) -> Color {
        return gameViewModel.checkWord(wordIndex: wordIndex) ?  Color.green.opacity(0.3) : Color.gray.opacity(0.3)
    }
    
    var exitButton: some View {
        Button(action: {
            routeManager.reset()
        }) {
            Text("Quit")
                .foregroundColor(.white)
                .padding()
                .background(Color.purple)
                .cornerRadius(8)
        }
    }
    
    var claimPointsButton: some View {
        Group {
            Title(title: "Level completed")
            Button(action: {
                routeManager.reset()
                gameViewModel.gameCompletedAddPoints()
            }) {
                Text("Claim Points")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
            }
        }
    }
    
    func gameComplete() -> some View {
        Group {
            if gameViewModel.gameComplete() {
                claimPointsButton
            } else {
                exitButton
            }
        }
    }

}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(levelObject: LevelObject(level: "Level 1", category: "Test", listWords: ["String", "String"]))
    }
}
