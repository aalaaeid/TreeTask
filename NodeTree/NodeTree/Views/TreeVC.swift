//
//  TreeVC.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import UIKit


class TreeVC: UIViewController {

    var tree = Tree.getAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .red
    }



}


/// we can make horizantal stack cutom view, and each Hstack has label an button and Vstack has that HStack
//
