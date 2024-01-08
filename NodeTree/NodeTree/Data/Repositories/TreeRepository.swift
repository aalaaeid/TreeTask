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
    func fetchTree() -> AnyPublisher<Data, Error>
    /// Fetch all Childs of tree ID
    /// - Parameter treeID: ID of a given tree
    func fetchChilds(treeID: String) -> AnyPublisher<Data, Error>
 

}



struct TreeRepository: DefaultTreeRepository {
    
    private let apiProvider = APIProvider<TreeEndPoint>()
    
    func fetchTree() -> AnyPublisher<Data, Error> {
        apiProvider
            .getData(from: .getRoot)
            .eraseToAnyPublisher()
    }
    
    func fetchChilds(treeID: String) -> AnyPublisher<Data, Error> {
        apiProvider
            .getData(from: .getChildren(treeID: treeID))
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

