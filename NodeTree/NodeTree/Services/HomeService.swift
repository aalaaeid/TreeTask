//
//  HomeService.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import Foundation
import Combine



protocol TreeServiceProtocol {
    /// Fetch drafted Inspections for a user
    func fetchTree() -> AnyPublisher<[Tree], RemoteError>
    /// Fetch all inspections (which are not drafted) of the authenticated  user, for a given month
    /// - Parameter month:  month of inspections
    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], RemoteError>
 

}


//struct TreeService: TreeServiceProtocol {
//    
//    func fetchTree() -> AnyPublisher<[Tree], RemoteError> {
//        
//    }
//    
//    func fetchChilds(treeID: String) -> AnyPublisher<[Tree], RemoteError> {
//        
//    }
//    
//    
//}
