//
//  EndPointProtocol.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//

import Foundation


enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum RequestParams {
    case body(_: Encodable)
    case url(_: [String: Any]?)
    case path(_: [String: Any]?)
}

protocol APIRequest {
    var baseURL: URL { get }
    var path: EndPoint { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams? { get }
    var headers: [String: Any]? { get }
}
