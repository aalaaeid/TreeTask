//
//  TreeViewModel.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine


class TreeViewModel {
    
    var bag: Set<AnyCancellable> = []
    private var treeService = TreeService.init()
    var viewUpdates: PassthroughSubject<ViewUpdates, Never> = .init()
}


extension TreeViewModel {
    enum ViewUpdates {
        case fetchTree(tree: [Tree])
        case fetchAllNodes(info: Tree)
        case showToastMessage(message: String)
    }
}
