//
//  RemoteError.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation


enum APIErrors: Int, Error {
    case badRequest = 400
    case unAuthorized = 401
    case tooManyRequests = 429
    case serverError = 500
    case requestBuilderFailed
    
    var errorDescription: String? {
        switch self {
        case .tooManyRequests:
            return "You made too many requests within a window of time and have been rate limited. Back off for a while."
        case .serverError:
            return "Server error."
        case .requestBuilderFailed:
            return "request Failed"
        default:
            return "Something goes wrong."
        }
    }
}


enum RemoteError: Error {
    case invalidURL
    case dataNil
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .dataNil:
            return "Empty data."
        case .decodingError:
            return "Data has invalid format."
        default:
            return "Something goes wrong."
        }
    }
}
