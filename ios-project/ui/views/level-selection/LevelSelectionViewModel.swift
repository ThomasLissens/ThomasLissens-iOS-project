//
//  LevelSelection.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation
import Combine

/*class LevelSelectionViewModel: ObservableObject, Identifiable {
    var results: [LevelObject] = []
    
    var onLevelsReceived: (() -> Void)?
    
    var onError: ((String) -> Void)?
    
    func fetchLevels() {
        API.Client.shared.get(.search) { (result: Result<API.Types.Response.LevelObjects, API.Types.Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let succes):
                    self.parseResults(succes)
                case .failure(let failure):
                    self.onError?(failure.localizedDescription)
                }
            }
        }
    }
    
    private func parseResults(_ results: API.Types.Response.LevelObjects) {
        var localResults = [LevelObject]()
        
        for result in results.result {
            let localResult = LevelObject(
                levelName: result.levelName,
                categoryName: result.categoryName,
                wordsList: result.wordsList
            )
            localResults.append(localResult)
        }
        
        self.results = localResults
        onLevelsReceived?()
    }

}

extension LevelSelectionViewModel {
    struct LevelObject {
        var levelName: String
        var categoryName: String
        var wordsList: Array<String>
    }
}*/

protocol LevelSelectionViewModelnterface {
    
}

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
    @Published var error: LevelObjectsError?
    @Published private(set) var isRefreshing = false
                
    private var bag = Set<AnyCancellable>()
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent(DbRoutes.autosaveLevelObjects)
    
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL),
           let autoSavedLevels = try? LevelObjects(json: data) {
            levels = autoSavedLevels
        }
    }
         
    private func autosave() {
        save(to: autosaveURL)
        print("autosaved to \(autosaveURL)")
    }
    
    private func save(to url: URL) {
        do {
            let data = try levels.json()
            try data.write(to: url)
        } catch let error {
            print("LevelObjects: error while saving \(error.localizedDescription)")
        }
    }
       
    var levelList: [LevelObject] {
        levels.levelObjects
    }
    
    @MainActor
    private func fetchLevels() async {
        let apiConnectionString = "http://localhost:3000/api/words/levels"
        if let url = URL(string: apiConnectionString) {
            isRefreshing = true
            hasError = false

            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw LevelObjectsError.invalidStatusCode
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
                    self.error = LevelObjectsError.custom(error: error)
                }
            }

            isRefreshing = false
        }
    }
}
    
extension LevelSelectionViewModel {
    enum LevelObjectsError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        
        var errorDescription: String? {
            switch self {
                case .failedToDecode:
                    return "Failed to decode response object"
                case .custom(let error):
                    return error.localizedDescription
                case .invalidStatusCode:
                    return "Response code is invalid"
            }
        }
    }
}
