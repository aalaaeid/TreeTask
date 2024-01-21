//
//  HomeService.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine



protocol DefaultTreeRepository {
    /// Fetch Root Tree
    func fetchTree() -> AnyPublisher<[Tree], Error>
    /// Fetch all Childs of tree ID
    /// - Parameter treeID: ID of a given tree
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error>
 

}



struct TreeRepository: DefaultTreeRepository {
    
    private let apiProvider = APIProvider()
    
    func fetchTree() -> AnyPublisher<[Tree], Error> {
        let request = URLRequestBuilder(path: .getRoot)
            .set(method: .get)
        
       return apiProvider
            .getData(from: request)
            .eraseToAnyPublisher()
    }
    
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error> {
        let request = URLRequestBuilder(path: .getChilds)
            .set(method: .get)
            .set(parameters: .path(["structID" : treeID]))
        
        return apiProvider
            .getData(from: request)
            .eraseToAnyPublisher()
    }
    
    
}


extension TreeRepository {
    enum WeatherServiceErrors: Error {
        case treeIDNil
        
        var errorDescription: String? {
            switch self {
                
            case .treeIDNil:
                return "Something goes wrong."

            }
        }
    }

}

