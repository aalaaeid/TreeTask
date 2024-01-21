////
////  APIProtocol.swift
////  NetworkExample
////

import Foundation
import Combine



class APIProvider {
    
    func getData<T: APIRequest, U: Decodable>(from request: T) -> AnyPublisher<U, Error> {

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
    private func loadData<U: Decodable>(with request: URLRequest) -> AnyPublisher<U, Error> {

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

