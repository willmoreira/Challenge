//
//  DetailCharacterViewController.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit
import SDWebImage

class DetailCharacterViewController: UIViewController {
    
    // MARK: - Properties
    
    var character: CharactersResponse.Result? {
        didSet{
            updateMovieImage()
        }
    }
    
    private var imgCharacter: UIImageView = {
        let imgCharacter = UIImageView()
        imgCharacter.accessibilityIdentifier = "imgCharacter"
        return imgCharacter
    }()
    
    private let imgBackground: UIImageView = {
        let imgBackground = UIImageView()
        imgBackground.accessibilityIdentifier = "imgBackgroundDetail"
        imgBackground.image = UIImage(named: "imgBackgroundDetail")
        
        return imgBackground
    }()
    
    private let vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.layer.cornerRadius = 10
        return vwContainer
    }()
    
    private let vwNotebook: NotebookView = {
        let vwNotebook = NotebookView()
        vwNotebook.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
        return vwNotebook
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgCharacter.layer.cornerRadius = 10
        imgCharacter.clipsToBounds = true
    }
    
    // MARK: - Private Methods
    
    private func setupBackButton() {
        navigationItem.title = "Detalhes do Personagem"
        navigationController?.navigationBar.topItem?.title = "Voltar"
    }
    
    private func setupLayout() {
        imgBackground.translatesAutoresizingMaskIntoConstraints = false
        vwNotebook.translatesAutoresizingMaskIntoConstraints = false
        imgCharacter.translatesAutoresizingMaskIntoConstraints = false
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imgBackground)
        view.addSubview(imgCharacter)
        vwContainer.addSubview(vwNotebook)
        view.addSubview(vwContainer)
        
        NSLayoutConstraint.activate([
            //TODO: validar no iphone 8
            imgBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imgBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imgBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imgBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            vwNotebook.topAnchor.constraint(equalTo: vwContainer.topAnchor),
            vwNotebook.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            vwNotebook.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            vwNotebook.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor),
            
            imgCharacter.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imgCharacter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            imgCharacter.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imgCharacter.heightAnchor.constraint(equalTo: imgCharacter.widthAnchor),
            
            vwContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vwContainer.heightAnchor.constraint(equalToConstant: 200),
            vwContainer.topAnchor.constraint(equalTo: imgCharacter.bottomAnchor, constant: 24),
            vwContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            vwContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
        ])
        setupLabels()
    }
    
    private func setupLabels() {
        if let character = character {
            vwNotebook.addTextInLine(parameterText: "Nome: " + character.name)
            vwNotebook.addTextInLine(parameterText: "Espécie: " + character.species)
            vwNotebook.addTextInLine(parameterText: "Situação: " + character.status.rawValue)
            vwNotebook.addTextInLine(parameterText: "Nasceu: " + character.origin.name)
            vwNotebook.addTextInLine(parameterText: "Vive em: " + character.location.name)
        }
    }
    
    // MARK: - Helper
    
    private func updateMovieImage() {
        if let imgPathUrl = character?.image {
            let imageUrl = URL(string: imgPathUrl)
            imgCharacter.sd_setImage(with: imageUrl)
        }
    }
}
