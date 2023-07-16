//
//  ListCharactersViewModel.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import Foundation

protocol ListCharactersActionsDelegate: AnyObject {
    func updateListCharacter()
}

protocol ListCharactersViewModelDelegate: AnyObject {
    func goesToFilterCharacter()
    func goesToDetailCharacter(_ index: Int)
    func requestCharacterList()
    func characterListSize() -> Int
    func getCharacter(index: Int) -> CharactersResponse.Result
}

class ListCharactersViewModel: ListCharactersViewModelDelegate {
    
    // MARK: - Properties
    
    weak var delegate: ListCharactersActionsDelegate?
    var listCharacterCoordinator: ListCharactersCoordinatorDelegate?
    
    let service: ListCharactersService
    var page: Int = 1
    var totalPages: Int = 100
    var charactersList: [CharactersResponse.Result] = []
    var isLoadNextPageInProgress = false
    
    // MARK: - Initialization
    
    init(service: ListCharactersService = ListCharactersService()) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func requestCharacterList() {
        guard page <= totalPages, !isLoadNextPageInProgress else { return }
        isLoadNextPageInProgress = true
        service.doRequestListCharacters(page: page) { result in
            switch result {
            case let .success(charactersResponse):
                self.page += 1
                self.totalPages = charactersResponse.info.pages
                self.charactersList.append(contentsOf: charactersResponse.results)
                self.delegate?.updateListCharacter()
                self.isLoadNextPageInProgress = false
            case .failure:
                break
            }
        }
    }
    
    func goesToFilterCharacter() {
        listCharacterCoordinator?.goesToFilterCharacter()
    }
    
    func goesToDetailCharacter(_ index: Int) {
        listCharacterCoordinator?.goesToDetailCharacter(result: charactersList[index])
    }
    
    func characterListSize() -> Int {
        return charactersList.count
    }
    
    func getCharacter(index: Int) -> CharactersResponse.Result {
        return charactersList[index]
    }
}
