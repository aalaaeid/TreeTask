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
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
    }

    func configure(with tree: Tree) {
        nameLabel.text = tree.structDesc
    }
}

