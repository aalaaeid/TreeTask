//
//  NetworkDisconnectedVC.swift
//  NodeTree
//
//  Created by Alaa Eid on 08/01/2024.
//

import UIKit

class NetworkDisconnectedVC: UIViewController {

    init(state: String) {
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var state: String
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
