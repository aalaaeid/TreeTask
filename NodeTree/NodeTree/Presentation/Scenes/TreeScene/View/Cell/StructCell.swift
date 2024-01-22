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
//    var indentationConstraint: CGFloat = 0
    let nameLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    var revealImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
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
        
        contentView.addSubview(contentStackView)
        contentStackView.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: contentView.bottomAnchor,
                         trailing: contentView.trailingAnchor)
        revealImageView.constrainWidth(constant: 25)
        contentStackView.addArrangedSubviews([nameLabel, revealImageView])
    }
    
    func set(indentationConstraint: CGFloat){
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: indentationConstraint,
                                                      bottom: 0, right: 0)
    }

    func configure(with tree: String) {
        nameLabel.text = tree//tree.structDesc
    }
    
    func configure(with isExpanded: Bool) {

        revealImageView.image = isExpanded ? chevronDown : chevronRight
    }
}

