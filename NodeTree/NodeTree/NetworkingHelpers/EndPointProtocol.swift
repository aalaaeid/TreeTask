//
//  EndPointProtocol.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//

import Foundation


protocol EndpointProtocol {
    var baseURL: String { get }
    
    var absoluteURL: String { get }
    
    var params: [String: String] { get }
    
    var headers: [String: String] { get }
}



