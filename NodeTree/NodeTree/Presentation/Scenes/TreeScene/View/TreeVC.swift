//
//  TreeVC.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import UIKit
import Combine

enum TreeBehaviour {
    case expandedWithNodes(childs: [Tree])
    case expandedEmpty
    case notExpanded
}

struct TreeTest: Hashable {
    var name: String
    var image: String
}
class TreeVC: UIViewController {

    
    // MARK: -

    var viewModel = TreeVC.ViewModel()
    private var bag: Set<AnyCancellable> = []
    
    @IBOutlet weak var treeCollectionView: UICollectionView!
    
    
    var datasource : UICollectionViewDiffableDataSource<String,Tree>!
    
    //MARK: - lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        treeCollectionView.collectionViewLayout = layout
        
        let cellreg = UICollectionView.CellRegistration<UICollectionViewListCell, Tree>() { cell, indexPath, name in
            var config =  cell.defaultContentConfiguration()
            config.text = name.structDesc
            cell.contentConfiguration = config
        
              let snap = self.datasource.snapshot(for: "Groups")
              let snapItems = snap.snapshot(of: name, includingParent: false)
              let labelAccessory: UICellAccessory =
                   snap.isExpanded(name) ? .label(text: "-") : .label(text: "+")
               let hasChildren = snapItems.items.count > 0  //name.childnodecount != "0"
            
            cell.accessories = hasChildren ? [labelAccessory] : []
            
        }
        self.datasource = UICollectionViewDiffableDataSource<String,Tree>(collectionView: treeCollectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellreg, for: indexPath, item: item)
        }
        
        treeCollectionView.delegate = self

    
        viewModel.fetchRoot()
 
        bindViewModel()
    }
    
    
    //MARK: - viewSetup
    func bindViewModel() {
        viewModel
            .viewUpdates
            .sink { [weak self] (viewModelUpdate) in
                guard let self = self else { return }
                
                switch viewModelUpdate {
                    
                case .fetchRoot(tree: let tree):
                    viewModel.fetchNodeOf(parent: tree[0])


                case .fetchAllChildsOf(Root: let parent, childs: let childs):
                    var snap = NSDiffableDataSourceSectionSnapshot<Tree>()
                    snap.append([parent], to: nil) // root
                    snap.append(childs, to: parent)
                    for child in childs {
                        if child.childnodecount != "0" {
                            snap.append(child.childs, to: child)
                        }
                    }
                    self.datasource.apply(snap, to: "Groups", animatingDifferences: true)
                    
                case .showToastMessage(message: let message):
                    //show popup alert
                    return
                }
            }.store(in: &bag)
        
    }



}


//MARK: - UICollectionViewDelegate
extension TreeVC: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        var snap = self.datasource.snapshot(for: "Groups")
        guard let snapOFIndex = self.datasource.itemIdentifier(for: indexPath) else {return false}
        let snap2 = snap.snapshot(of: snapOFIndex, includingParent: false)
        let hasChildren = snap2.items.count > 0
        if hasChildren {
            if snap.isExpanded(snapOFIndex) {
                snap.collapse([snapOFIndex])
            } else {
                snap.expand([snapOFIndex])
            }
            self.datasource.apply(snap, to: "Groups")
        }
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
        return !hasChildren
        
    }
    

}
