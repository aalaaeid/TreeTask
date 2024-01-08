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
                    
                    self?.viewUpdates.send(.fetchRoot(tree: response.data))
                    
                }
            )
            .store(in: &bag)
    }
    
    func fetchNodeWith(treeID: String) {
        
    }
    
    
}


extension TreeVC.ViewModel {
    enum ViewUpdates {
        case fetchRoot(tree: [Tree])
        case fetchAllChilds(childs: [Tree])
        case showToastMessage(message: String)
    }
}
