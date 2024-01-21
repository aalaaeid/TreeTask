//
//  UseCases.swift
//  NodeTree
//
//  Created by Alaa Eid on 21/01/2024.
//

import Foundation
import Combine


protocol FetchTreeUseCase {
    /// Fetch Root Tree
    func fetchTree() -> AnyPublisher<[Tree], Error>
    /// Fetch all Childs of tree ID
    /// - Parameter treeID: ID of a given tree
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], Error>
 

}

protocol TreeViewModelUseCase {
    func fetchRoot()
    func fetchNodeOf(parent: Tree)
}
