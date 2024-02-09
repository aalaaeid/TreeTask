//
//  URLRequestBuilderMocking.swift
//  NodeTreeTests
//
//  Created by Alaa Eid on 09/02/2024.
//

import Foundation
@testable import NodeTree



enum URLRequestBuilderMocking: String {
       
    case getChilds = "GetChildren"
    case getRoot = "GetRoot"
    
    var path: String {
        
        switch self {
            
        case .getChilds:
            return Bundle.rootBundle.path(forResource: "TreeData", ofType: "json")!
        case .getRoot:
            return Bundle.childBundle.path(forResource: "childsData", ofType: "json")!
        }
    }
    
}

extension Bundle {
    public class var rootBundle: Bundle {
        return Bundle(for: TreeRepositoryTests.self)
    }
    
    public class var childBundle: Bundle {
        return Bundle(for: TreeRepositoryTests.self)
    }
}
