//
//  TreeDataSource.swift
//  NodeTree
//
//  Created by Alaa Eid on 29/12/2023.
//

import Foundation
import UIKit


enum BranchType {
    case root
    case child
}

class TreeDataSource: NSObject {
    
    var root = Tree.getRoot()
    private var childs = [Tree]()
    private var branchType: BranchType
    private var collectionView: UICollectionView
    
    init(branchType: BranchType,
         collectionView: UICollectionView) {

        self.collectionView = collectionView
        self.branchType = branchType
        
    }
    
}

//MARK: - UICollectionViewDataSource
extension TreeDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return root.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if root[section].isExpanded {
            
            return childs.count
            
        } else {
            
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: String(describing: ChildCell.self),
                                 for: indexPath) as? ChildCell else {
            assertionFailure("can not dequeueReusableCell")
            return UICollectionViewCell()
        }
        cell.setupChildCellWith(child: childs)
//        cell.childCollectionView.dataSource = self
//        cell.childCollectionView.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TreeCell.self), for: indexPath) as? TreeCell else {
            assertionFailure("can not dequeueReusableCell")
            return UICollectionReusableView()
        }
        header.index = indexPath.section
        header.delegate = self
        return header
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension TreeDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width) - 24, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width) - 12, height: 60)
    }
}


//MARK: - TreeCellProtocol
extension TreeDataSource: TreeCellProtocol {
    
    func didTapTreeAction(_ cell: TreeCell, index: Int) {
       
        if branchType == .root {
            root[index].isExpanded = !root[index].isExpanded
        } else {
       
            childs[index].isExpanded = !childs[index].isExpanded
        }
      
        let structID = root[index].treeID
        childs = Tree.getChildren(structID: structID)
   
       
        let indexSet = IndexSet(integer: index)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
       
        

    }
    
    
}
