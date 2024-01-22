//
//  UseCases.swift
//  NodeTree
//
//  Created by Alaa Eid on 21/01/2024.
//

import Foundation
import Combine


protocol TreeUseCaseProtocol {
    func fetchTree() -> AnyPublisher<[Tree], Error>
}



class TreeUseCase: TreeUseCaseProtocol {
    
    private let treeRepo: RemoteTreeRepository
    
    
    init(treeRepo: RemoteTreeRepository){
        self.treeRepo = treeRepo
    }
        
    func fetchTree() -> AnyPublisher<[Tree], Error> {
        treeRepo.fetchTree()
    }
    

    
}

