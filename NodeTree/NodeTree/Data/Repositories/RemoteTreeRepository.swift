//
//  HomeService.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine


struct RemoteTreeRepository: FetchTreeUseCase {
    
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


