//
//  Game.swift
//  ios-project
//
//  Created by Thomas Lissens on 03/01/2024.
//

import Foundation

class Game {
    private(set) var category: String
    private(set) var level: String
    private(set) var wordsList: [Word]
    
    init(category: String, level: String, wordsList: [String]) {
        self.category = category
        self.level = level
        self.wordsList = wordsList.map { Word(word: $0) }
    }
}

struct Word {
    let word: String
    let correct: Bool
    let letters: [String]

    init(word: String, correct: Bool = false, letters: [String] = []) {
        self.word = word
        self.correct = correct
        if letters.isEmpty {
            self.letters = Array(repeating: "", count: word.count)
        } else {
            self.letters = letters
        }
    }
}
