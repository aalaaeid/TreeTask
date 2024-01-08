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

    var isExpanded: Bool
    var childs: Int
    let treeID: String
    
    enum CodingKeys: CodingKey {
        case name
        case childs
        case treeID
    }
}







extension Tree {
    static func getRoot() -> [Tree] {
        return [Tree(name: "Root1", isExpanded: false, childs: 5, treeID:"Root1")]
               
    }
    
    static func getChildren(structID: String) -> [Tree] {

        if structID == "Root1" {
            return [Tree(name: "Child1 of Root1", childs: 5, treeID:"Child1"),
                    Tree(name: "Child2 of Root1", childs: 5, treeID:"Child2"),
                    Tree(name: "Child3 of Root1", childs: 5, treeID:"Child3"),
                    Tree(name: "Child4 of Root1", childs: 5, treeID:"Child4")]
        } else if structID == "Child1 of Root1" {
            
            return [Tree(name: "Child1 of Child1", childs: 5, treeID:"Child1"),
                    Tree(name: "Child2 of Child1", childs: 5, treeID:"Child2")]
        } else {
            return [Tree(name: "Child1 of other", childs: 5, treeID:"Child1"),
                    Tree(name: "Child2 of other", childs: 5, treeID:"Child2"),
                    Tree(name: "Child3 of other", childs: 5, treeID:"Child3"),
                    Tree(name: "Child4 of other", childs: 5, treeID:"Child4")]
        }
    }
}
