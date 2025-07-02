//
//  DetailCharacterViewController.swift
//  Challenge
//
//  Created by William on 14/07/23.
//

import UIKit
import SDWebImage

class DetailCharacterViewController: UIViewController {

    // MARK: - Properties

    var character: CharacterCellViewModel? {
        didSet {
            updateMovieImage()
        }
    }

    private var imgCharacter: UIImageView = {
        let imgCharacter = UIImageView()
        imgCharacter.layer.cornerRadius = 10
        imgCharacter.accessibilityIdentifier = ConfigurationStrings.imgCharacter
        return imgCharacter
    }()

    private let imgVwBackground: UIImageView = {
        let imgVwBackground = UIImageView()
        imgVwBackground.accessibilityIdentifier = ConfigurationStrings.imgBackgroundDetail
        imgVwBackground.image = UIImage(named: ConfigurationStrings.imgBackgroundDetail)
        return imgVwBackground
    }()

    private let vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.layer.cornerRadius = 10
        return vwContainer
    }()

    private let vwNotebook: NotebookView = {
        let vwNotebook = NotebookView()
        return vwNotebook
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgCharacter.clipsToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")

        AppUtility.lockOrientation(.portrait)
        setupBackButton()
    }

    // MARK: - Private Methods

    private func setupBackButton() {
        navigationItem.title = ProjectStrings.characterDetails.localized
        navigationController?.navigationBar.topItem?.title = ProjectStrings.back.localized
    }

    private func setupLayout() {
        imgVwBackground.translatesAutoresizingMaskIntoConstraints = false
        vwNotebook.translatesAutoresizingMaskIntoConstraints = false
        imgCharacter.translatesAutoresizingMaskIntoConstraints = false
        vwContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imgVwBackground)
        view.addSubview(imgCharacter)
        vwContainer.addSubview(vwNotebook)
        view.addSubview(vwContainer)

        NSLayoutConstraint.activate([
            imgVwBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imgVwBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imgVwBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imgVwBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            vwNotebook.topAnchor.constraint(equalTo: vwContainer.topAnchor),
            vwNotebook.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            vwNotebook.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            vwNotebook.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor),

            imgCharacter.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imgCharacter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            imgCharacter.widthAnchor.constraint(equalToConstant: 200),
            imgCharacter.heightAnchor.constraint(equalTo: imgCharacter.widthAnchor),

            vwContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vwContainer.heightAnchor.constraint(equalToConstant: 200),
            vwContainer.topAnchor.constraint(equalTo: imgCharacter.bottomAnchor, constant: 24),
            vwContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            vwContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48)
        ])
        setupLabels()
    }

    private func setupLabels() {
        if let character = character {
            vwNotebook.addTextInLine(parameterText: ProjectStrings.name.localized + character.name)
            vwNotebook.addTextInLine(parameterText: ProjectStrings.species.localized + character.species)
            vwNotebook.addTextInLine(parameterText: ProjectStrings.situation.localized + character.status)
            vwNotebook.addTextInLine(parameterText: ProjectStrings.heWasBorn.localized + character.origin)
            vwNotebook.addTextInLine(parameterText: ProjectStrings.liveIn.localized + character.location)
        }
    }

    // MARK: - Helper

    private func updateMovieImage() {
        if let imgPathUrl = character?.imageURL {
            let imageUrl = URL(string: imgPathUrl)
            imgCharacter.sd_setImage(with: imageUrl)
        }
    }
}
