//
//  TableViewCharacterCells.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit
import SDWebImage

class TableViewCharacterCells: UITableViewCell {

    // MARK: - Properties

    let nameLabel = UILabel()
    let customImageView = UIImageView()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(ConfigurationStrings.fatalErrorMessage)
    }

    // MARK: - Private Methods

    private func setupLayoutCell() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none

        contentView.addSubview(customImageView)
        customImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customImageView.widthAnchor.constraint(equalToConstant: 80),
            customImageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.centerYAnchor.constraint(equalTo: customImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }

    private func setupBackground(url: String) {
        let backgroundImageView = UIImageView()
        backgroundImageView.sd_setImage(with: URL(string: url))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0.15
        backgroundView = backgroundImageView
    }

    // MARK: - Public Methods

    func setupCell(name: String, urlImage: String) {
        setupBackground(url: urlImage)
        nameLabel.text = name
        customImageView.sd_setImage(with: URL(string: urlImage))
        customImageView.layer.masksToBounds = true
        customImageView.layer.cornerRadius = 40
        customImageView.layoutIfNeeded()
    }
}
