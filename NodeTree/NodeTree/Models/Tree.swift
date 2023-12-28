//
//  Tree.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation


struct Tree: Codable {
    let name: String
    var isExpanded: Bool = false
    let childs: [Tree]
    let treeID: String
}


extension Tree {
    static func getAll() -> [Tree] {
        return [Tree(name: "parent1", childs: [Tree(name: "child1",
                                                    childs: [Tree(name: "ChildChild1", childs: [],
                                                                  treeID: "a")], treeID: "b"),
                                               Tree(name: "child2", childs: [], treeID: "d")],
                     treeID: "c"),
                Tree(name: "parent2", childs: [Tree(name: "child3", childs: [], treeID: "e"),
                                               Tree(name: "child4", childs: [], treeID: "f"),
                                               Tree(name: "child5", childs: [], treeID: "g"),
                                               Tree(name: "child6", childs: [], treeID: "h")],
                             treeID: "i")]
    }
}
