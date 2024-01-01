//
//  TreeCell.swift
//  NodeTree
//
//  Created by Alaa Eid on 28/12/2023.
//

import UIKit

protocol TreeCellProtocol: AnyObject {
    func didTapTreeAction(_ cell: TreeCell, index: Int )
}

class TreeCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var treeActionButton: UIButton!
    
    weak var delegate: TreeCellProtocol?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        contentView.backgroundColor = .blue
        
    }

    @IBAction func treeAction(_ sender: Any) {
        
        delegate?.didTapTreeAction(self, index: index)
    }
}
