//
//  TreeViewModel.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine

protocol TreeViewModelProtocl {
    func fetchRoot()
    func fetchNodeOf(parent: Tree)
}

extension TreeVC {
    class ViewModel {
        
        private var treeUseCase = TreeRepository.init()
        var bag: Set<AnyCancellable> = []
        var viewUpdates: PassthroughSubject<ViewUpdates, Never> = .init()
    }
    
    
}

extension TreeVC.ViewModel: TreeViewModelProtocl {
    
    func fetchRoot() {
        
        treeUseCase.fetchTree()
            .decode(type: [Tree].self, decoder: JSONDecoder.init())
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    
                    switch completion {
                        
                    case .finished:
                        print("finished fetching Root")
                    case .failure(let error):
                        print("error happened in Fetching Root")
                        
                        self?.viewUpdates.send(.showToastMessage(message: error.localizedDescription))
                        
                    }
                },
                receiveValue: { [weak self] response in
                    print(response, "👻")
                    
                    self?.viewUpdates.send(.fetchRoot(tree: response))
                    
                }
            )
            .store(in: &bag)
    }
    
    func reloadNodeOf(parent: Tree) {
        self.viewUpdates.send(.reloadChildStateOf(Root: parent))
    }
    
    func fetchNodeOf(parent: Tree) {
        
        treeUseCase.fetchChilds(treeID: parent.structID)
            .decode(type: [Tree].self, decoder: JSONDecoder.init())
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    
                    switch completion {
                        
                    case .finished:
                        print("finished fetching Childs of \(parent.structDesc)")
                    case .failure(let error):
                        print("error happened in Fetching Childs of \(parent.structDesc) ")
                        
                        self?.viewUpdates.send(.showToastMessage(message: error.localizedDescription))
                        
                    }
                },
                receiveValue: { [weak self] response in
                    print(response, "👻")
                    
                    self?.viewUpdates.send(.fetchAllChildsOf(Root: parent, childs: response))
                    
                }
            )
            .store(in: &bag)
    }
    
    
}


extension TreeVC.ViewModel {
    enum ViewUpdates {
        case fetchRoot(tree: [Tree])
        case fetchAllChildsOf(Root: Tree, childs: [Tree])
        case reloadChildStateOf(Root: Tree)
        case showToastMessage(message: String)
    }
}
