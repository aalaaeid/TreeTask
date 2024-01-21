////
////  APIProtocol.swift
////  NetworkExample
////
////  Created by Tyler Thompson on 3/28/20.
////  Copyright © 2020 World Wide Technology. All rights reserved..
////
//
import Foundation
import Combine



class APIProvider {
    
    func getData<T: APIRequest>(from request: T) -> AnyPublisher<Data, Error> {

        do {
            let request = try buildURLRequest(for: request)

            return loadData(with: request)
                .eraseToAnyPublisher()
        } catch {
            
            return Fail(error: RemoteError.invalidURL)
                            .eraseToAnyPublisher()
        }
    
        
    }
    
    func buildURLRequest<T: APIRequest>(for request: T) throws -> URLRequest {
      return try URLRequestBuilder(with: request.baseURL, path: request.path)
          .set(method: request.method)
          .set(headers: request.headers)
          .set(parameters: request.parameters)
          .build()
    }

    
    // MARK: - Getting data
    private func loadData(with request: URLRequest) -> AnyPublisher<Data, Error> {

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
            .eraseToAnyPublisher()
    }
    

    

}

