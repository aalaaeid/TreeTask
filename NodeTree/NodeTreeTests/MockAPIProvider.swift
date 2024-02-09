//
//  MockAPIProvider.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import Foundation
import Combine
@testable import NodeTree

class MockAPIProvider: APIProviderProtocol {
    

    var mockPath: String?
    
    func getData<U>(from request: URLRequest) -> AnyPublisher<U, Error> where U : Decodable {
        

       guard let path = mockPath,
             let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
           return Fail(error: NSError(domain: "MockErrorDomain", code: 123, userInfo: nil)).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return Just(data)
            .decode(type: U.self, decoder: decoder)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
  


    
}
