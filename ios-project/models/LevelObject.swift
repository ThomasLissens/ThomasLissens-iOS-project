//
//  LevelObject.swift
//  ios-project
//
//  Created by Thomas Lissens on 03/01/2024.
//

import Foundation

struct LevelObjects: Codable {
    private(set) var levelObjects = [LevelObject]()
    
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        print("LevelObject = \(String(data: encoded, encoding: .utf8) ?? "nil")")
        return encoded
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(LevelObjects.self, from: json)
    }
    
    init() {
        
    }
}

struct LevelObject: Codable, Equatable {
    let level: String
    let category: String
    let listWords: [String]
}
