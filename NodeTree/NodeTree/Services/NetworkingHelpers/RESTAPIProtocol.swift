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



class APIProvider<Endpoint: EndpointProtocol> {
    func getData(from endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        guard let request = performRequest(for: endpoint) else {
            return Fail(error: RemoteError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return loadData(with: request)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Request building
    private func performRequest(for endpoint: Endpoint) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.absoluteURL) else {
            return nil
        }

        urlComponents.queryItems = endpoint.params.compactMap({ param -> URLQueryItem in
            return URLQueryItem(name: param.key, value: param.value)
        })

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadRevalidatingCacheData,
                                    timeoutInterval: 30)
        
        endpoint.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
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
