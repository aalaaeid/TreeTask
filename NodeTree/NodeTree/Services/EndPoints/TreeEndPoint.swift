//
//  TreeEndPoint.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//

import Foundation


enum TreeEndPoint: EndpointProtocol {
    case getRoot
    case getChildren(treeID: String)
    
    var baseURL: String {
        return "http://localhost:3000/"
    }
    
    var absoluteURL: String {
        switch self {
        case .getRoot:
            return baseURL + "GetRoot"
        case let .getChildren(treeID):
            return baseURL + "GetChildren/structID=\(treeID)"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .getRoot:
            return [:]
        case .getChildren:
            return [:]
        }
    }
    
    var headers: [String : String] {
        return [
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
}
