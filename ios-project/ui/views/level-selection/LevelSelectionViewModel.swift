//
//  LevelSelection.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import Combine


class LevelSelectionViewModel: ObservableObject {
    @Published private var levels = LevelObjects() {
        didSet {
            autosave()
            if !isRefreshing {
                Task {
                    await fetchLevels()
                }
            }
        }
    }
    @Published var hasError = false
    @Published var error: APIError?
    @Published private(set) var isRefreshing = false
                
    private var bag = Set<AnyCancellable>()
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent(DbRoutes.autosaveLevelObjects)
    
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL),
           let autoSavedLevels = try? LevelObjects(json: data) {
            levels = autoSavedLevels
        } else {
            levels = LevelObjects()
        }
    }
         
    private func autosave() {
        save(to: autosaveURL)
    }
    
    private func save(to url: URL) {
        do {
            let data = try levels.json()
            try data.write(to: url)
        } catch let error {
            print("Level Objects: error while saving \(error.localizedDescription)")
        }
    }
       
    var levelList: [LevelObject] {
        levels.levelObjects
    }
    
    @MainActor
    private func fetchLevels() async {
        let apiConnectionString = "https://guessery-api.cyclic.app/api/words/levels"
        if let url = URL(string: apiConnectionString) {
            isRefreshing = true
            hasError = false

            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.invalidStatusCode
                }

                let responseDataString = String(data: data, encoding: .utf8)
                print("Response Data: \(responseDataString ?? "Unable to convert data to string")")

                let decoder = JSONDecoder()
                let levels = try decoder.decode(LevelObjects.self, from: data)

                await MainActor.run {
                    self.levels = levels
                    self.save(to: self.autosaveURL)
                }
            } catch {
                await MainActor.run {
                    hasError = true
                    self.error = APIError.custom(error: error)
                }
            }

            isRefreshing = false
        }
    }
}

