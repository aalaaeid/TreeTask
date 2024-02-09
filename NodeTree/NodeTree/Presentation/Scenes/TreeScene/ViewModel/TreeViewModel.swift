//
//  TreeViewModel.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine


protocol TreeViewModelProtocol {
    func fetchRoot()
    func fetchNodeOf(parent: Tree)
}


extension TreeVC {
    class ViewModel {
        
        private let treeUseCase: TreeUseCaseProtocol
        private let childUseCase: ChildUseCaseProtocol
        
        init(treeUseCase: TreeUseCaseProtocol,
             childUseCase: ChildUseCaseProtocol) {
            
            self.treeUseCase = treeUseCase
            self.childUseCase = childUseCase
        }
        
        var bag: Set<AnyCancellable> = []
        var fetchTreeSuccess: PassthroughSubject<[Tree], Never> = .init()
        var fetchChildsSuccess: PassthroughSubject<(Root: Tree, childs: [Tree]), Never> = .init()
        var reloadChildSuccess: PassthroughSubject<Tree, Never> = .init()

    }
    
}



extension TreeVC.ViewModel: TreeViewModelProtocol {
    
    func fetchRoot() {
        
        treeUseCase.fetchTree()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: {  completion in
                    
                    
                    switch completion {
                        
                    case .finished:
                        print("finished fetching Root")
                    case .failure(let error):
                        print("error happened in Fetching Root \(error)")
                                                
                    }
                },
                receiveValue: { [weak self] response in
                    print(response, "👻")
                    self?.fetchTreeSuccess.send(response)
                }
            )
            .store(in: &bag)
    }
    
    func reloadNodeOf(parent: Tree) {
        self.reloadChildSuccess.send(parent)
    }
    
    func fetchNodeOf(parent: Tree) {
        
        childUseCase.fetchChilds(treeID: parent.structID)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: {  completion in
                    
                    switch completion {
                        
                    case .finished:
                        print("finished fetching Childs of \(parent.structDesc)")
                    case .failure(let error):
                        print("error \(error) happened in Fetching Childs of \(parent.structDesc) ")
                        
                    }
                },
                receiveValue: { [weak self] response in
                    print(response, "👻")
                    self?.fetchChildsSuccess.send((Root: parent, childs: response))
                }
            )
            .store(in: &bag)
    }
    
    
}

