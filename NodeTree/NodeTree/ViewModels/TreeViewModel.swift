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
    func fetchNodeWith(treeID: String)
}

class TreeViewModel {
    
    private var treeService = TreeService.init()
    var bag: Set<AnyCancellable> = []
    var viewUpdates: PassthroughSubject<ViewUpdates, Never> = .init()
}



extension TreeViewModel: TreeViewModelProtocl {
    func fetchRoot() {
        
        treeService.fetchTree()
            .decode(type: RemoteResponse<[Tree]>.self, decoder: JSONDecoder.init())
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
                    
                    self?.viewUpdates.send(.fetchTree(tree: response.data))
                    
                }
            )
            .store(in: &bag)
    }
    
    func fetchNodeWith(treeID: String) {
        
    }
    
    
}


extension TreeViewModel {
    enum ViewUpdates {
        case fetchTree(tree: [Tree])
        case fetchAllNodes(info: Tree)
        case showToastMessage(message: String)
    }
}
