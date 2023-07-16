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
        selectionStyle = .none
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(name: String, urlImage: String) {
        setupBackground(url: urlImage)
        nameLabel.text = name
        customImageView.sd_setImage(with: URL(string: urlImage))
        customImageView.layer.masksToBounds = true
        customImageView.layer.cornerRadius = 40
        customImageView.layoutIfNeeded()
    }
    
    private func setupBackground(url: String) {
        
        let backgroundImageView = UIImageView()
        backgroundImageView.sd_setImage(with: URL(string: url))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.1
        self.backgroundView = backgroundImageView
    }
}
