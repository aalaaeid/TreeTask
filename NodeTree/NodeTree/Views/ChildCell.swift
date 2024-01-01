//
//  ChildCell.swift
//  NodeTree
//
//  Created by Alaa Eid on 29/12/2023.
//

import UIKit

class ChildCell: UICollectionViewCell {

    @IBOutlet weak var childCollectionView: UICollectionView!
    
    var dataSource: TreeDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .green
        
   
   
        childCollectionView.register(UINib(nibName: String(describing: ChildCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ChildCell.self))
        
        childCollectionView.register(UINib(nibName: String(describing: TreeCell.self), bundle: nil),
                                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: String(describing: TreeCell.self))

    
    }
    
    func setupChildCellWith(child: [Tree]){
        self.dataSource?.root = child
        dataSource = TreeDataSource(branchType: .child, collectionView: childCollectionView)
        
        childCollectionView.delegate = dataSource
        childCollectionView.dataSource = dataSource

    }

}

