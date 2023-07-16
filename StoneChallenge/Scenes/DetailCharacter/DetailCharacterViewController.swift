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

    var viewModel: DetailCharacterViewModelDelegate?
    var character: CharactersResponse.Result? {
        didSet{
            updateMovieImage()
        }
    }
    
    private var imgCustom: UIImageView = {
        let imgCustom = UIImageView()
        return imgCustom
    }()
    
    private let imgBackground: UIImageView = {
        let imgBackground = UIImageView()
        return imgBackground
    }()
    
    private let vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.layer.cornerRadius = 10
        return vwContainer
    }()
    
    private let notebookView: NotebookView = {
        let notebookView = NotebookView()
        notebookView.frame = CGRect(x: 0, y: 0, width: 250, height: 300)
        return notebookView
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
        imgCustom.layer.cornerRadius = 10
        imgCustom.clipsToBounds = true
    }
        
    // MARK: - Private Methods
 
    private func setupBackButton() {
        navigationItem.title = "Detalhes do Personagem"
        navigationController?.navigationBar.topItem?.title = "Voltar"
    }
    
    private func setupLayout() {
        imgBackground.image = UIImage(named: "ImgBackgroundDetail")
        imgBackground.translatesAutoresizingMaskIntoConstraints = false
        notebookView.translatesAutoresizingMaskIntoConstraints = false
        imgCustom.translatesAutoresizingMaskIntoConstraints = false
        vwContainer.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imgBackground)
        view.addSubview(imgCustom)
        vwContainer.addSubview(notebookView)
        view.addSubview(vwContainer)
        
        NSLayoutConstraint.activate([
            //TODO: validar no iphone 8
            imgBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imgBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imgBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imgBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            notebookView.topAnchor.constraint(equalTo: vwContainer.topAnchor),
            notebookView.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor),
            notebookView.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor),
            notebookView.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor),
            
            imgCustom.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imgCustom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            imgCustom.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imgCustom.heightAnchor.constraint(equalTo: imgCustom.widthAnchor),
            
            vwContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vwContainer.heightAnchor.constraint(equalToConstant: 200),
            vwContainer.topAnchor.constraint(equalTo: imgCustom.bottomAnchor, constant: 24),
            vwContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            vwContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
        ])
        setupLabels()
    }
    
    private func setupLabels() {
        if let character = character {
            notebookView.addText(text: "Nome: " + character.name)
            notebookView.addText(text: "Espécie: " + character.species)
            notebookView.addText(text: "Situação: " + character.status.rawValue)
            notebookView.addText(text: "Nasceu: " + character.origin.name)
            notebookView.addText(text: "Vive em: " + character.location.name)
        }
    }
    
    // MARK: - Helper

    private func updateMovieImage() {
        if let imgPathUrl = character?.image {
            let imageUrl = URL(string: imgPathUrl)
            imgCustom.sd_setImage(with: imageUrl)
        }
    }
}
