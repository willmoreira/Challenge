//
//  FilterCharacterViewController.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

class FilterCharacterViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: FilterCharacterViewModelDelegate?
    
    private let vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.backgroundColor = UIColor(red: 180/255.0, green: 214/255.0, blue: 91/255.0, alpha: 1.0)
        vwContainer.layer.cornerRadius = 10
        return vwContainer
    }()
    
    private let tfFilter: UITextField = {
        let tfFilter = UITextField()
        tfFilter.placeholder = "Digite o nome para buscar"
        tfFilter.accessibilityIdentifier = "tfFilter"
        tfFilter.borderStyle = .roundedRect
        return tfFilter
    }()
    
    private let pckVwFilter: UIPickerView = {
        let pckVwFilter = UIPickerView()
        pckVwFilter.accessibilityIdentifier = "pckVwFilter"
        return pckVwFilter
    }()
    
    private let btnFilter: UIButton = {
        let btnFilter = UIButton(type: .system)
        btnFilter.setTitle("Filtrar", for: .normal)
        btnFilter.setTitleColor(.black, for: .normal)
        btnFilter.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnFilter.layer.borderWidth = 1.0
        btnFilter.layer.borderColor = UIColor.black.cgColor
        btnFilter.backgroundColor = UIColor(red:245/255.0, green: 237/255.0, blue: 117/255.0, alpha: 1.0)
        btnFilter.accessibilityIdentifier = "btnFilter"
        btnFilter.clipsToBounds = true
        return btnFilter
    }()
    
    private let imgVwBackground: UIImageView = {
        let imgVwBackground = UIImageView()
        imgVwBackground.image = UIImage(named: "imgBackgroundFilter")
        imgVwBackground.contentMode = .scaleAspectFill
        imgVwBackground.alpha = 0.8
        return imgVwBackground
    }()
    
    private let filterOptions = ["Alive", "Dead", "Unknown"]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setupLayout()
        setupPickerView()
        setupDissmissKeyboard()
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
    
    // MARK: - Private Methods
    private func setupDissmissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupLayout() {
        
        view.backgroundColor = .white
        
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        tfFilter.translatesAutoresizingMaskIntoConstraints = false
        btnFilter.translatesAutoresizingMaskIntoConstraints = false
        imgVwBackground.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imgVwBackground)
        view.addSubview(vwContainer)
        vwContainer.addSubview(tfFilter)
        vwContainer.addSubview(btnFilter)
        
        NSLayoutConstraint.activate([
            imgVwBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imgVwBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imgVwBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imgVwBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            vwContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vwContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vwContainer.heightAnchor.constraint(equalToConstant: 320),
            vwContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            vwContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            
            tfFilter.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            tfFilter.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: 24),
            tfFilter.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 24),
            tfFilter.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -24),
            
            btnFilter.centerXAnchor.constraint(equalTo: vwContainer.centerXAnchor),
            btnFilter.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -24),
            btnFilter.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: 24),
            btnFilter.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -24),
            btnFilter.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        view.layoutIfNeeded()
        
        btnFilter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackButton() {
        navigationItem.title = "Filtro"
        navigationController?.navigationBar.topItem?.title = "Voltar"
    }
    
    private func setupPickerView() {
        pckVwFilter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pckVwFilter)
        
        NSLayoutConstraint.activate([
            pckVwFilter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pckVwFilter.topAnchor.constraint(equalTo: tfFilter.bottomAnchor, constant: 0),
            pckVwFilter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            pckVwFilter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            pckVwFilter.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        pckVwFilter.dataSource = self
        pckVwFilter.delegate = self
    }
    
    // MARK: - Actions
    
    @objc private func filterButtonTapped() {
        let selectedOptionIndex = pckVwFilter.selectedRow(inComponent: 0)
        let selectedOption = filterOptions[selectedOptionIndex]
        let filterText = tfFilter.text ?? ""
        viewModel?.filterCharacters(name: filterText , status: selectedOption)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - PickerViewDelegate

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

