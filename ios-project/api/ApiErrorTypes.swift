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
