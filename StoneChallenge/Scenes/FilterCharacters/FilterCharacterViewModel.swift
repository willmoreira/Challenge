//
//  FilterCharacterViewModel.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import Foundation

protocol FilterCharacterViewModelActionsDelegate: AnyObject {
    func updateListCharacter(name: String, status: String)
}

protocol FilterCharacterViewModelDelegate: AnyObject {
    func filterCharacters(name: String, status: String)
    func passDelegateFilterCharacter(delegate: FilterCharacterViewModelActionsDelegate)
}

class FilterCharacterViewModel: FilterCharacterViewModelDelegate {

    // MARK: - Properties

    weak var delegate: FilterCharacterViewModelActionsDelegate?
    var coordinator: FilterCharacterCoordinatorDelegate?
    let service: FilterCharacterService
  
    // MARK: - Initialization

    init(service: FilterCharacterService = FilterCharacterService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func filterCharacters(name: String, status: String) {
        delegate?.updateListCharacter(name: name, status: status)
    }
    
    func passDelegateFilterCharacter(delegate: FilterCharacterViewModelActionsDelegate) {
        self.delegate = delegate
    }
}

