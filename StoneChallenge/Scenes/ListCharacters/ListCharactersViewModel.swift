//
//  ListCharactersViewModel.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import Foundation

protocol ListCharactersViewControllerDelegate: AnyObject {
    func updateListCharacter()
}

protocol ListCharactersViewModelDelegate: AnyObject {
    func goesToFilterCharacter()
    func goesToDetailCharacter(_ index: Int)
    func requestCharacterList()
    func requestCharacterListInitial(name: String, status: String)
    func characterListSize() -> Int
    func getCharacter(index: Int) -> CharactersResponse.Result
}

class ListCharactersViewModel: ListCharactersViewModelDelegate {
    
    // MARK: - Properties
    
    weak var viewController: ListCharactersViewControllerDelegate?
    var coordinator: ListCharactersCoordinatorDelegate?
    let service: ListCharactersService
    
    var name: String?
    var status: String?
    var page: Int = 1
    var totalPages: Int = 1
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
        service.doRequestListCharacters(page: page, name: name, status: status) { result in
            switch result {
            case let .success(charactersResponse):
                self.page += 1
                if let charactersResponseInfo = charactersResponse.info,
                   let charactersResponseResults = charactersResponse.results {
                    self.totalPages = charactersResponseInfo.pages
                    self.charactersList.append(contentsOf: charactersResponseResults)
                }
                self.viewController?.updateListCharacter()
                self.isLoadNextPageInProgress = false
            case .failure:
                break
            }
        }
    }
    
    func requestCharacterListInitial(name: String, status: String) {
        page = 1
        totalPages = 1
        charactersList = []
        self.name = name
        self.status = status
        requestCharacterList()
    }
    
    func goesToFilterCharacter() {
        coordinator?.goesToFilterCharacter()
    }
    
    func goesToDetailCharacter(_ index: Int) {
        coordinator?.goesToDetailCharacter(result: charactersList[index])
    }
    
    func characterListSize() -> Int {
        return charactersList.count
    }
    
    func getCharacter(index: Int) -> CharactersResponse.Result {
        return charactersList[index]
    }
}
