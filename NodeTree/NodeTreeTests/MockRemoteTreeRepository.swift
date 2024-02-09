//
//  MockRemoteTreeRepository.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import Foundation
import Combine
@testable import NodeTree

class  MockRemoteTreeRepository: RemoteTreeRepositoryProtocol {
    
      var fetchTreeCalled = false
      var fetchChildsCalled = false
 
    
    func fetchTree() -> AnyPublisher<[NodeTree.Tree], Error> {
        fetchTreeCalled =  true
        return Empty().eraseToAnyPublisher()
    }
    
    func fetchChilds(treeID: String) -> AnyPublisher<[NodeTree.Tree], Error> {
        fetchChildsCalled =  true
        return  Empty().eraseToAnyPublisher()
    }
    
    
}
