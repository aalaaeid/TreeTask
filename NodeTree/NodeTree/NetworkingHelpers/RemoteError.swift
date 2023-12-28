//
//  RemoteError.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation


enum RemoteError: Error {
    
    /// Used when the error in request != nil
    case requestError(e: Error)

    ///used when there's an error returned from the backend
    case decodingError(e: Error)

    ///used when we can't get the data from the request, data == nil
    case dataError(message: String)
    
    
    ///Used when the operation failed from backend
    case operationError(reason: String)
    
    // MARK: - Internal errors
    case noInternet
    // MARK: - API errors
    case badAPIRequest
    
    // MARK: - Auth errors
    case unauthorized(message:String)
    
    // MARK: - Unknown errors
    case unknown
    case serverError
    case timeout
}



extension RemoteError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Check Internet Connection"
            
        case .badAPIRequest:
            return "Bad Api Request"
            
        case .unauthorized(let message):
            return message
            
        case .unknown:
            return "Unexpected Error Occured"
            
        case .serverError:
            return "Can not Connect to Server"
            
        case .timeout:
            return "Connection Timedout"
            
        case .requestError(e: let error):
            return error.localizedDescription
            
        case .decodingError(e: let error):
            return error.localizedDescription
            
        case .dataError(message: let message):
            return message
            
        case .operationError(reason: let reason):
            return reason

        }
    }
}

