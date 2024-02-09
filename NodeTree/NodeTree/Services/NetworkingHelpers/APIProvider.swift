////
////  APIProtocol.swift
////  NetworkExample
////

import Foundation
import Combine

protocol APIProviderProtocol {
    func getData<U: Decodable>(from request: URLRequest) -> AnyPublisher<U, Error>
}


class APIProvider: APIProviderProtocol {
    
    func getData<U: Decodable>(from request: URLRequest) -> AnyPublisher<U, Error> {

        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError({ error -> Error in
                APIErrors(rawValue: error.code.rawValue) ?? RemoteError.unknownError
            })
            .map { $0.data }
            .handleEvents(receiveSubscription: { (v) in
                print(v)
            }, receiveOutput: { (d) in
                print(String(data: d, encoding: .utf8))
            }, receiveCompletion: nil, receiveCancel: nil, receiveRequest: nil)
            .decode(type: U.self, decoder: JSONDecoder())
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
        
    }


}

