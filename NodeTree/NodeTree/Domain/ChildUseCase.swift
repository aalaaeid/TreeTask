//
//  ChildUseCase.swift
//  NodeTree
//
//  Created by Alaa Eid on 22/01/2024.
//

import Foundation
import Combine


protocol ChildUseCaseProtocol {
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error>
}

class ChildUseCase: ChildUseCaseProtocol {
    
    private let treeRepo: RemoteTreeRepository
    
    
    init(treeRepo: RemoteTreeRepository){
        self.treeRepo = treeRepo
    }
        
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error> {
        treeRepo.fetchChilds(treeID: treeID)
    }
    
    
}
