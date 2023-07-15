//
//  TableViewCharacterCells.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit
import SDWebImage

import UIKit

class TableViewCharacterCells: UITableViewCell {
    
    let nameLabel = UILabel()
    let customImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(customImageView)
        contentView.addSubview(nameLabel)
        
        nameLabel.numberOfLines = 2
      
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        customImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        customImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: customImageView.centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customImageView.layer.masksToBounds = true
        customImageView.layer.cornerRadius = customImageView.frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(name: String, urlImage: String) {
        nameLabel.text = name
        customImageView.sd_setImage(with: URL(string: urlImage))
    }
}
