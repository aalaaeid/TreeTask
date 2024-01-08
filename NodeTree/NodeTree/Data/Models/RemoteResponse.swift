//
//  RemoteResponse.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//

import Foundation


struct RemoteResponse<T: Codable>: Codable {

    var success: Bool
    var message: String
    var data:T

}
