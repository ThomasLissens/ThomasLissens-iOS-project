//
//  ApiTypes.swift
//  ios-project
//
//  Created by Thomas Lissens on 02/01/2024.
//

import Foundation

extension API {
    
    enum Types {
        
        enum Response {
            struct LevelObjects: Decodable {
                var result: [Result]

                    struct Result: Decodable {
                        var levelName: String
                        var categoryName: String
                        var wordsList: [String]

                        enum CodingKeys: String, CodingKey {
                            case levelName
                            case categoryName
                            case wordsList
                        }
                    }
            }
            
        }
        
        enum Request {
            struct Empty: Encodable {}
        }
        
        enum Error: LocalizedError {
            case generic(reason: String)
            case `internal`(reason: String)
            
            var errorDescription: String? {
                switch self {
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return "Internal Error: \(reason)"
                }
            }
        }
        
        enum Endpoint {
            case search
            
            var url: URL {
                var components = URLComponents()
                components.host = "localhost:9000"
                components.scheme = "https"
                switch self {
                case .search:
                    components.path = "/api/words"
                }
                return components.url!
            }
        }
        
        enum Method: String {
            case get
        }

    }
    
}
