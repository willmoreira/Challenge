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
}

class FilterCharacterViewModel: FilterCharacterViewModelDelegate {

    // MARK: - Properties

    weak var delegate: FilterCharacterViewModelActionsDelegate?
    var filterCharacterCoordinator: FilterCharacterCoordinatorDelegate?
    
    let service: FilterCharacterService
    var page: Int = 1
    var totalPages: Int = 100
    var charactersList: [CharactersResponse.Result] = []
    var isLoadNextPageInProgress = false
    
    // MARK: - Initialization

    init(service: FilterCharacterService = FilterCharacterService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func filterCharacters(name: String, status: String) {
        delegate?.updateListCharacter(name: name, status: status)
    }
}

