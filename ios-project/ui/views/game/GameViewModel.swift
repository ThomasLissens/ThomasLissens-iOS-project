//
//  GameModel.swift
//  ios-project
//
//  Created by Thomas Lissens on 04/01/2024.
//

import Foundation



final class GameViewModel: ObservableObject {
    @Published var game: Game
    
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
    
    init(levelObject: LevelObject) {
        let randomWords = levelObject.listWords.shuffled().prefix(5)
        self.game = Game(category: levelObject.category, level: levelObject.level, wordsList: randomWords.map { Word(word: $0) })
    }

    private func addPoint(amount: Int = 1) {
        var updatedStats = stats
        updatedStats.points += amount
        UserDefaults.standard.set(updatedStats, forKey: userDefaultsKey)
    }
    
    private func endGame() {
        addPoint(amount: 5)
        var updatedStats = stats
        updatedStats.gamesWon += 1
        UserDefaults.standard.set(updatedStats, forKey: userDefaultsKey)
    }
        
    func changeLetter(indexWord: Int, indexLetter: Int, letter: String) {
        game.changeLetter(indexWord: indexWord, indexLetter: indexLetter, letter: letter)
    }
    
    func shouldNotShowTextField(indexWord: Int, indexLetter: Int) -> Bool {
        game.isEmptyLetter(indexWord: indexWord, indexLetter: indexLetter)
    }
    
    func checkWord(wordIndex: Int) -> Bool {
        return game.isWordCorrect(wordIndex: wordIndex)
    }
    
    func gameCompletedAddPoints() {
        if game.gameComplete() {
            endGame()
        }
    }
    
    func gameComplete() -> Bool {
        return game.gameComplete()
    }
}
