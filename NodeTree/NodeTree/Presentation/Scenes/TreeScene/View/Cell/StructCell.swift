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
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    var revealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var contemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    let chevronRight = UIImage(systemName: "chevron.right",
                               withConfiguration: UIImage.SymbolConfiguration(scale: .small))
    let chevronDown = UIImage(systemName: "chevron.down",
                              withConfiguration: UIImage.SymbolConfiguration(scale: .small))
    
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
        
        contentView.addSubview(contemStackView)
        contemStackView.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
        revealImageView.constrainWidth(constant: 25)
        contemStackView.addArrangedSubviews([nameLabel, revealImageView])
    }

    func configure(with tree: Tree) {
        nameLabel.text = tree.structDesc
    }
    
    func configure(with isExpanded: Bool) {

        revealImageView.image = isExpanded ? chevronDown : chevronRight
    }
}

