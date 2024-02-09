//
//  MockChildUseCase.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import Foundation
import Combine
@testable import NodeTree

class MockChildUseCase: ChildUseCaseProtocol {
    var fetchChildResult: AnyPublisher<[Tree], Error>!

    func fetchChilds(treeID: String) -> AnyPublisher<[NodeTree.Tree], Error> {
        return fetchChildResult.eraseToAnyPublisher()
    }
    
    
}
