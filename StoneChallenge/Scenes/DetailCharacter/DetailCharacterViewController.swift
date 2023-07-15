//
//  DetailCharacterViewController.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit
import SDWebImage

class DetailCharacterViewController: UIViewController {
    
    var viewModel: DetailCharacterViewModelDelegate?
    var character: CharactersResponse.Result? {
        didSet{
            updateFilm()
        }
    }

    var imgCustom: UIImageView = {
        let imgCustom = UIImageView()
        imgCustom.contentMode = .scaleAspectFit
        return imgCustom
    }()
    
    var lblName: UILabel = {
        let lblName = UILabel()
        lblName.font = UIFont.systemFont(ofSize: 24)
        lblName.textColor = UIColor(red: 38/255.0, green: 54/255.0, blue: 60/255.0, alpha: 1.0)
        lblName.textAlignment = .center
        lblName.numberOfLines = 2
        return lblName
    }()
    
    var lblSpecies: UILabel = {
        let lblSpecies = UILabel()
        lblSpecies.textColor = UIColor(red: 38/255.0, green: 54/255.0, blue: 60/255.0, alpha: 1.0)
        lblSpecies.numberOfLines = 0
        lblSpecies.textAlignment = .center
        return lblSpecies
    }()
    
    var lblGender: UILabel = {
        let lblGender = UILabel()
        lblGender.textColor = UIColor(red: 38/255.0, green: 54/255.0, blue: 60/255.0, alpha: 1.0)
        lblGender.numberOfLines = 0
        lblGender.textAlignment = .center
        return lblGender
    }()
    
    var lblType: UILabel = {
        let lblType = UILabel()
        lblType.textColor = UIColor(red: 38/255.0, green: 54/255.0, blue: 60/255.0, alpha: 1.0)
        lblType.numberOfLines = 0
        lblType.textAlignment = .center
        return lblType
    }()
    
    private let imgBackground: UIImageView = {
        let imgBackground = UIImageView()
        imgBackground.contentMode = .scaleAspectFill
        imgBackground.translatesAutoresizingMaskIntoConstraints = false
        return imgBackground
    }()
    
    private let vwContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 11/255.0, green: 238/255.0, blue: 210/255.0, alpha: 1.0)
        view.layer.cornerRadius = 10
        return view
    }()
    
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
    
    private func setupBackButton() {
        navigationItem.title = "Detalhes do Personagem"
        navigationController?.navigationBar.topItem?.title = "Voltar"
    }
    
    private func setupLayout() {
        
        imgBackground.image = UIImage(named: "ImgBackgroundDetail")
        view.addSubview(imgBackground)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let screenSize = UIScreen.main.bounds.size
            let screenHeight = screenSize.height
            
            if screenHeight >= 812 {
                imgBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                imgBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 128).isActive = true
            }
        }
        
        imgBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imgBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imgBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imgBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        imgCustom.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imgCustom)

        imgCustom.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imgCustom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        imgCustom.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imgCustom.heightAnchor.constraint(equalToConstant: 200).isActive = true

        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwContainer)
        
        vwContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        vwContainer.heightAnchor.constraint(equalToConstant: 200).isActive = true
        vwContainer.topAnchor.constraint(equalTo: imgCustom.bottomAnchor, constant: 24).isActive = true
        vwContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        vwContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        
        setupLabels()
    }
    
    private func setupLabels() {
        lblName.text = character?.name
        lblSpecies.text = character?.species
        lblGender.text = character?.gender.rawValue
        lblType.text = character?.type
        
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblSpecies.translatesAutoresizingMaskIntoConstraints = false
        lblGender.translatesAutoresizingMaskIntoConstraints = false
        lblType.translatesAutoresizingMaskIntoConstraints = false
        
        vwContainer.addSubview(lblName)
        vwContainer.addSubview(lblSpecies)
        vwContainer.addSubview(lblGender)
        vwContainer.addSubview(lblType)
        
        lblName.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 16).isActive = true
        lblName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        lblName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
     
        lblSpecies.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 24).isActive = true
        lblSpecies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        lblSpecies.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        lblGender.topAnchor.constraint(equalTo: lblSpecies.bottomAnchor, constant: 16).isActive = true
        lblGender.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblGender.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        lblGender.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
       
        lblType.topAnchor.constraint(equalTo: lblGender.bottomAnchor, constant: 16).isActive = true
        lblType.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblType.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        lblType.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        view.layoutIfNeeded()
    }
    
    private func updateFilm() {
        if let imgPathUrl = character?.image {
            let imageUrl = URL(string: imgPathUrl)
            imgCustom.sd_setImage(with: imageUrl)
        }
        lblName.text = character?.name
        lblSpecies.text = character?.species
    }
}


