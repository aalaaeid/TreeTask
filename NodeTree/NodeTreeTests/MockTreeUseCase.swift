//
//  MockTreeUseCase.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import Foundation
import Combine
@testable import NodeTree


class MockTreeUseCase: TreeUseCaseProtocol {
    var fetchTreeResult: AnyPublisher<[Tree], Error>!

    func fetchTree() -> AnyPublisher<[NodeTree.Tree], Error> {
      
        return fetchTreeResult.eraseToAnyPublisher()
    }
    
    
}
