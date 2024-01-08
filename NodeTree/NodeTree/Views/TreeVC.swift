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

    
    // MARK: - View Model
    var root = Tree.getRoot()
let systemImages = [TreeTest(name: "name 1", image: "square.and.arrow.up"),
                    TreeTest(name: "name2", image: "trash"),
                    TreeTest(name: "name3", image: "paperplane")]
    var viewModel = TreeVC.ViewModel()
    private var bag: Set<AnyCancellable> = []
    
    @IBOutlet weak var treeCollectionView: UICollectionView!
    
    
    var datasource : UICollectionViewDiffableDataSource<String,String>!
 

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        treeCollectionView.collectionViewLayout = layout

        let cellreg = UICollectionView.CellRegistration<UICollectionViewListCell, String>() { cell, indexPath, name in
            var config = cell.defaultContentConfiguration()
            config.text = name
            cell.contentConfiguration = config
            
            let snap = self.datasource.snapshot(for: "Groups")
              let snap2 = snap.snapshot(of: name, includingParent: false)
              let hasChildren = snap2.items.count > 0
            cell.accessories = hasChildren ? [.outlineDisclosure()] : []
        }
        self.datasource = UICollectionViewDiffableDataSource<String,String>(collectionView: treeCollectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellreg, for: indexPath, item: item)
        }
        
        view.backgroundColor = .red
   
        
        var snap = NSDiffableDataSourceSectionSnapshot<String>()
        snap.append(["Pep", "Marx"], to: nil) // root
        snap.append(["Manny", "Moe", "Jack"], to: "Pep")
        snap.append(["Groucho", "Harpo", "Chico", "Other"], to: "Marx")
        snap.append(["Zeppo", "Gummo"], to: "Other")
        self.datasource.apply(snap, to: "Groups", animatingDifferences: false)

    
        
    }
    
    
    func bindViewModel() {
        viewModel
            .viewUpdates
            .sink { [weak self] (viewModelUpdate) in
                guard let self = self else { return }
                
                switch viewModelUpdate {
                    
                case .fetchRoot(tree: let tree):
                    treeCollectionView.reloadData()
                case .fetchAllChilds(childs: let childs):
                    treeCollectionView.reloadData()
                case .showToastMessage(message: let message):
                    //show popup alert
                    return
                }
            }.store(in: &bag)
        
    }



}

