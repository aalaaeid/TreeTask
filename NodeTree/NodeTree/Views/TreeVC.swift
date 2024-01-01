//
//  TreeVC.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import UIKit


class TreeVC: UIViewController {

    
    @IBOutlet weak var treeCollectionView: UICollectionView!
    
    var dataSource: TreeDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .red
   
        dataSource = TreeDataSource(branchType: .root, collectionView: treeCollectionView)
        treeCollectionView.delegate = dataSource
        treeCollectionView.dataSource = dataSource
        
        treeCollectionView.register(UINib(nibName: String(describing: ChildCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ChildCell.self))
        
        treeCollectionView.register(UINib(nibName: String(describing: TreeCell.self), bundle: nil),
                                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: String(describing: TreeCell.self))

    
        
    }



}






