//
//  TreeVC.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import UIKit
import Combine

class TreeVC: UIViewController {

    
    // MARK: - View Model
    var viewModel = TreeVC.ViewModel()
    private var bag: Set<AnyCancellable> = []
    
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






