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
    var gameOver: Bool = false
    var wordsList: [Word]
    
    private(set) var points = 0
    
    init(category: String, level: String, wordsList: [String]) {
        self.category = category
        self.level = level
        self.wordsList = wordsList.map { Word(word: $0) }
        addRandomLetters()
        addRandomLetters()

    }
    
    init(category: String, level: String, wordsList: [Word]) {
        self.category = category
        self.level = level
        self.wordsList = wordsList
        addRandomLetters()
        addRandomLetters()

    }
    
    init(levelObject: LevelObject) {
        self.category = levelObject.category
        self.level = levelObject.level
        self.wordsList = levelObject.listWords.map { Word(word: $0) }
        addRandomLetters()
        addRandomLetters()

    }
    
    func changeLetter(indexWord: Int, indexLetter: Int, letter: String) {
        guard indexWord >= 0, indexWord < wordsList.count else {
            return
        }

        guard indexLetter >= 0, indexLetter < wordsList[indexWord].letters.count else {
            return
        }
        
        guard wordsList[indexWord].letters.count < 1 else {
            return
        }
        
        var updatedWords = wordsList
        var updatedLetters = wordsList[indexWord].letters

        updatedLetters[indexLetter] = letter
        updatedWords[indexWord] = Word(word: wordsList[indexWord].word, correct: wordsList[indexWord].correct, letters: updatedLetters)
    }
    
    func isEmptyLetter(indexWord: Int, indexLetter: Int) -> Bool {
        guard indexWord >= 0, indexWord < wordsList.count else {
            return true
        }

        guard indexLetter >= 0, indexLetter < wordsList[indexWord].letters.count else {
            return true
        }
        
        return !wordsList[indexWord].word[wordsList[indexWord].word.index(wordsList[indexWord].word.startIndex, offsetBy: indexLetter)].isLetter
    }
    
    func gameComplete() -> Bool {
        if wordsList.filter({$0.correct}).count == wordsList.count {
            return true
        }
        return false
    }
    
    func isWordCorrect(wordIndex: Int) -> Bool {
        guard wordIndex >= 0, wordIndex < wordsList.count else {
            return false
        }
        
        let word = wordsList[wordIndex].word
        var letters = wordsList[wordIndex].letters

        letters = letters.map { $0.isEmpty ? " " : $0 }
        
        let isCorrect = word == letters.joined()
        
        if isCorrect {
            if (wordsList[wordIndex].correct == false) {
                self.points += 1
            }
            wordsList[wordIndex].correct = true
        }

        return isCorrect
    }
    
    func indexesOfWrongLetters(indexWord: Int) -> [Int] {
        var differentIndexes: [Int] = []

        for (index, word) in wordsList.enumerated() {
            if index == indexWord {
                for (i, character) in word.word.enumerated() {
                    let arrayCharacter = word.letters[i].isEmpty ? " " : Array(word.letters[i])[0] // Handle empty strings in the array
                       if character != arrayCharacter {
                           differentIndexes.append(i)
                       }
                   }
            }
        }
        return differentIndexes
    }
    
    func addRandomLetters() {
        for (index, word) in wordsList.enumerated() {
            
            if let randomIndex = indexesOfWrongLetters(indexWord: index).randomElement() {
                var updatedWord = word
                let correctLetter = Array(word.word)[randomIndex]
                
                updatedWord.letters[randomIndex] = correctLetter.uppercased()

                var updatedWordsList = wordsList
                updatedWordsList[index] = updatedWord

                self.wordsList = updatedWordsList
            }
                    
        }
    }
}

struct Word {
    let word: String
    var correct: Bool = false
    var letters: [String]

    init(word: String, correct: Bool = false, letters: [String] = []) {
        self.word = word.uppercased()
        self.correct = correct
        if letters.isEmpty {
            self.letters = Array(repeating: "", count: word.count)
        } else {
            self.letters = letters
        }
    }
}
