//
//  ApiClientNew.swift
//  ios-project
//
//  Created by Thomas Lissens on 05/01/2024.
//

import Foundation

enum APIError: LocalizedError {
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

class APIClient {
    static func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        if let url = URL(string: urlString) {
            Task {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode) else {
                        completion(.failure(.invalidStatusCode))
                        return
                    }

                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.custom(error: error)))
                }
            }
        } else {
            completion(.failure(.custom(error: URLError(.badURL))))
        }
    }
}
