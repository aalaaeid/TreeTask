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
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .orange
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
        contentView.backgroundColor = .green

    }

    func configure(with tree: Tree) {
        print(tree, "++")
        nameLabel.text = tree.structDesc
    }
}

