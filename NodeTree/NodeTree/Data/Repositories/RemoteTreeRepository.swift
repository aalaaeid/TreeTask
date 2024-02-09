//
//  HomeService.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine

protocol RemoteTreeRepositoryProtocol {
    /// Fetch Root Tree
    func fetchTree() -> AnyPublisher<[Tree], Error>
    /// Fetch all Childs of tree ID
    /// - Parameter treeID: ID of a given tree
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error>
 

}

struct RemoteTreeRepository: RemoteTreeRepositoryProtocol {
    
    private let apiProvider: APIProviderProtocol
    
    init(apiProvider: APIProviderProtocol) {
        self.apiProvider = apiProvider
    }
    
    func fetchTree() -> AnyPublisher<[Tree], Error> {
        let request = URLRequestBuilder(path: .getRoot)
            .set(method: .get)
            .build()
        
       return apiProvider
            .getData(from: request)
            .eraseToAnyPublisher()
    }
    
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error> {
        let request = URLRequestBuilder(path: .getChilds)
            .set(method: .get)
            .set(parameters: .path(["structID" : treeID]))
            .build()
        
        return apiProvider
            .getData(from: request)
            .eraseToAnyPublisher()
    }
    
    
}


