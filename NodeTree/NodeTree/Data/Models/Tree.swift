//
//  Tree.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation

//section Root

struct Tree: Codable, Hashable {
    
    static func == (lhs: Tree, rhs: Tree) -> Bool {
        lhs.structID == rhs.structID
    }
    
    let structDesc, childnodecount: String
    let structID: String

    enum CodingKeys: String, CodingKey {
        case structDesc = "STRUCT_DESC"
        case childnodecount = "CHILDNODECOUNT"
        case structID = "STRUCT_ID"
    }
}

