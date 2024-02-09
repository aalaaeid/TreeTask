//
//  TreeVC.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import UIKit
import Combine


enum Section {
  case main
}

class TreeVC: UIViewController {

    
    // MARK: -

    var viewModel: TreeVC.ViewModel?
    private var bag: Set<AnyCancellable> = []
    
    @IBOutlet weak var treeCollectionView: UICollectionView!
    
    
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Tree>
    private typealias Snapshot = NSDiffableDataSourceSectionSnapshot<Tree>
    

    private var snapshot = Snapshot()

    var cellreg = UICollectionView.CellRegistration<StructCell, Tree> { cell, indexPath, itemIdentifier in}
    private lazy var dataSource = makeDataSource(cellRegistration: cellreg)
    
    var expandedSections: Set<Tree> = []



    //MARK: - lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

       
 
        bindViewModel()
        
        viewModel?.fetchRoot()
        
         cellreg = UICollectionView.CellRegistration<StructCell, Tree>() { cell, indexPath, item in

             let isExpanded =  self.expandedSections.contains(item)

             cell.configure(with: item)
           
             let hasChilds = (item.childnodecount != 0)
             cell.configureRoot(hasChilds: hasChilds, isExpanded: isExpanded)
             
             let childLevel = self.snapshot.level(of: item)
             cell.set(indentationConstraint: CGFloat(20 * childLevel))


       }
        

    }


    
    
    //MARK: - viewSetup
    func bindViewModel() {
        viewModel = ViewModel(treeUseCase: TreeUseCase(treeRepo: RemoteTreeRepository(apiProvider: APIProvider())),
                              childUseCase: ChildUseCase(treeRepo: RemoteTreeRepository(apiProvider: APIProvider())))
        
        viewModel?
            .fetchTreeSuccess
            .receive(on: RunLoop.main)
            .sink { [weak self] tree in
                guard let self = self else { return }
                applyRootSnapshot(with: tree)
            }.store(in: &bag)
        
        viewModel?
            .fetchChildsSuccess
            .receive(on: RunLoop.main)
            .sink { [weak self] (root: Tree, childs: [Tree]) in
                guard let self = self else { return }
                applyChildsSnapshot(with: childs, parent: root)

            }.store(in: &bag)
        
        viewModel?
            .reloadChildSuccess
            .receive(on: RunLoop.main)
            .sink { [weak self] parent in
                guard let self = self else { return }
                expandSnapshotFor(parent: parent)

            }.store(in: &bag)
        
        
    }



}


//MARK: - UICollectionViewDelegate
extension TreeVC: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let snapOFIndex = dataSource.itemIdentifier(for: indexPath) else {return}

        
        if !selectedSnapshotHasChilds(indexPath: indexPath) {
            
            viewModel?.fetchNodeOf(parent: snapOFIndex)
            
        } else {
            
            viewModel?.reloadNodeOf(parent: snapOFIndex)
        }
    
    }
    

}


extension TreeVC {
    
    private func setupCollectionView()  {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 50)
        treeCollectionView.collectionViewLayout = layout

        treeCollectionView.delegate = self
    }
    


    private func makeDataSource(cellRegistration: UICollectionView.CellRegistration<StructCell, Tree>) -> DataSource {
        return DataSource(collectionView: treeCollectionView) { collectionView, indexPath, itemIdentifier in
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                             for: indexPath,
                                                             item: itemIdentifier)

        }

    }

    func applyRootSnapshot(with treeItem: [Tree], animatingDifferences: Bool = true) {
        snapshot.append(treeItem, to: nil) // root


        dataSource.apply(snapshot, to: .main, animatingDifferences: animatingDifferences)
    }
    
    
    func applyChildsSnapshot(with childs: [Tree], parent: Tree, animatingDifferences: Bool = true) {
        let index = dataSource.indexPath(for: parent) ?? IndexPath()

        snapshot.append(childs, to: parent)
        if parent.childnodecount != 0 {
            snapshot.expand([parent])
            expandedSections.insert(parent)
        }

        treeCollectionView.reloadData()
        dataSource.apply(snapshot, to: .main, animatingDifferences: animatingDifferences)
    }
    
    func expandSnapshotFor(parent: Tree, animatingDifferences: Bool = true) {
       
        if parent.childnodecount != 0 {
            if snapshot.isExpanded(parent) {
                snapshot.collapse([parent])
                expandedSections.remove(parent)

            } else {
                snapshot.expand([parent])
                expandedSections.insert(parent)

            }
        }
        treeCollectionView.reloadData()
        dataSource.apply(snapshot, to: .main, animatingDifferences: animatingDifferences)
    }

    func selectedSnapshotHasChilds(indexPath: IndexPath) -> Bool {

        guard let treeIndex = self.dataSource.itemIdentifier(for: indexPath) else {return false}


        let snapOFIndex = snapshot.snapshot(of: treeIndex, includingParent: false)
        let hasChildren = snapOFIndex.items.count > 0
        return hasChildren

    }

    
    
}




