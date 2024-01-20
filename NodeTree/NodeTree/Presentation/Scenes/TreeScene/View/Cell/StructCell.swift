//
//  StructCell.swift
//  NodeTree
//
//  Created by Alaa Eid on 18/01/2024.
//

import UIKit

class StructCell: UICollectionViewCell {

    @IBOutlet weak var structNameLabel: UILabel!
    @IBOutlet weak var expandImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .green

    }

    func configure(with tree: Tree) {
        print(tree, "++")
        structNameLabel.text = tree.structDesc
    }
}

extension StructCell {
    typealias CellRegistration = UICollectionView.CellRegistration<StructCell, Tree>

    static func registration() -> CellRegistration {
        CellRegistration { cell, _, tree in
            cell.configure(with: tree)
        }
    }
}
