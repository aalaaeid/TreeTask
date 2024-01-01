//
//  Tree.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
//section Root

struct Tree: Codable {
    let name: String
    var isExpanded: Bool = false
    var childs: Int
    let treeID: String
}







extension Tree {
    static func getRoot() -> [Tree] {
        return [Tree(name: "Root1", childs: 5, treeID:"Root1")]
               
    }
    
    static func getChildren(structID: String) -> [Tree] {
        return [Tree(name: "Child1", childs: 5, treeID:"Child1"),
                Tree(name: "Child2", childs: 5, treeID:"Child2"),
                Tree(name: "Child3", childs: 5, treeID:"Child3"),
                Tree(name: "Child4", childs: 5, treeID:"Child4")]
    }
}
