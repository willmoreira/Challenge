//
//  FilterCharacterViewController.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

class FilterCharacterViewController: UIViewController {
    
    var viewModel: FilterCharacterViewModelDelegate?
    
    private let vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        vwContainer.layer.cornerRadius = 10
        return vwContainer
    }()
    
    private let tfFilter: UITextField = {
        let tfFilter = UITextField()
        tfFilter.placeholder = "Digite o nome para buscar"
        tfFilter.borderStyle = .roundedRect
        tfFilter.translatesAutoresizingMaskIntoConstraints = false
        return tfFilter
    }()
    
    private let pckVwFilter: UIPickerView = {
        let pvwFilter = UIPickerView()
        pvwFilter.translatesAutoresizingMaskIntoConstraints = false
        return pvwFilter
    }()
    
    private let btnFilter: UIButton = {
        let btnFilter = UIButton(type: .system)
        btnFilter.setTitle("Filtrar", for: .normal)
        btnFilter.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnFilter.setTitleColor(.black, for: .normal)
        btnFilter.layer.borderWidth = 1.0
        btnFilter.layer.borderColor = UIColor.black.cgColor
        btnFilter.backgroundColor = UIColor(red:245/255.0, green: 237/255.0, blue: 117/255.0, alpha: 1.0)
        btnFilter.translatesAutoresizingMaskIntoConstraints = false
        return btnFilter
    }()
    
    private let imgVwBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filterOptions = ["Alive", "Dead", "Unknown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupPickerView()
        //setupFilterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnFilter.layer.cornerRadius = btnFilter.frame.height / 2
        btnFilter.clipsToBounds = true
    }
    
    private func setupLayout() {
        imgVwBackground.image = UIImage(named: "imgBackgroundFilter")
        imgVwBackground.alpha = 0.8
        view.backgroundColor = .white
        view.addSubview(imgVwBackground)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let screenSize = UIScreen.main.bounds.size
            let screenHeight = screenSize.height
            
            if screenHeight >= 812 {
                imgVwBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                imgVwBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 128).isActive = true
            }
        }
        
        imgVwBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imgVwBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imgVwBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imgVwBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vwContainer)
        vwContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vwContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vwContainer.heightAnchor.constraint(equalToConstant: 360).isActive = true
        vwContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        vwContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
       
        
        vwContainer.backgroundColor = UIColor(red: 180/255.0, green: 214/255.0, blue: 91/255.0, alpha: 1.0)
        vwContainer.layer.cornerRadius = 10
        
        vwContainer.addSubview(tfFilter)
        tfFilter.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor).isActive = true
        tfFilter.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 24).isActive = true
        tfFilter.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 24).isActive = true
        tfFilter.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -24).isActive = true
        
        vwContainer.addSubview(pckVwFilter)
        pckVwFilter.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor).isActive = true
        pckVwFilter.topAnchor.constraint(equalTo: tfFilter.bottomAnchor, constant: -50).isActive = true
        pckVwFilter.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 24).isActive = true
        pckVwFilter.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -24).isActive = true
        
        vwContainer.addSubview(btnFilter)
        btnFilter.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor).isActive = true
        btnFilter.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -24).isActive = true
        btnFilter.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 24).isActive = true
        btnFilter.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -24).isActive = true
        btnFilter.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btnFilter.clipsToBounds = true
        
        view.layoutIfNeeded()

        btnFilter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackButton() {
        navigationItem.title = "Filtro"
        navigationController?.navigationBar.topItem?.title = "Voltar"
    }
    
    private func setupPickerView() {
        view.addSubview(pckVwFilter)
        
        pckVwFilter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pckVwFilter.topAnchor.constraint(equalTo: tfFilter.bottomAnchor, constant: 48).isActive = true
        pckVwFilter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        pckVwFilter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        pckVwFilter.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        pckVwFilter.dataSource = self
        pckVwFilter.delegate = self
    }
    
    private func setupFilterButton() {
        view.addSubview(btnFilter)
        
        btnFilter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnFilter.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48).isActive = true
        btnFilter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    @objc private func filterButtonTapped() {
        let selectedOptionIndex = pckVwFilter.selectedRow(inComponent: 0)
        let selectedOption = filterOptions[selectedOptionIndex]
        
        viewModel?.filterCharacters(with: selectedOption)
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension FilterCharacterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filterOptions[row]
    }
}








