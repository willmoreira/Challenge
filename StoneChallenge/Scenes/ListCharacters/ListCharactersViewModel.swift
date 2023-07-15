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
    var delegate: ListCharactersActionsDelegate? { get set }
    func goesToFilterCharacter()
    func goesToDetailCharacter(_ index: Int)
}

class ListCharactersViewModel: ListCharactersViewModelDelegate {
   
    weak var delegate: ListCharactersActionsDelegate?
    var listCharacterCoordinator: ListCharactersCoordinatorDelegate?
    
    let service: ListCharactersService
    var page: Int = 1
    var totalPages: Int = 100
    var charactersList: [CharactersResponse.Result] = []
    
    init(service: ListCharactersService = ListCharactersService()) {
        self.service = service
    }
    
    func requestApi() {
        
        guard page <= totalPages else { return }

        service.doRequestListCharacters(page: page) { result in

            switch result {
            case let .success(charactersResponse):
                self.page += 1
                self.totalPages = charactersResponse.info.pages
                self.charactersList.append(contentsOf: charactersResponse.results)
                self.delegate?.updateListCharacter()
    
            case .failure:
                break
            }
        }
    }
    
    func goesToFilterCharacter() {
        listCharacterCoordinator?.goesToFilterCharacter()
    }
    
    func goesToDetailCharacter(_ index: Int) {
        //TODO: validar essa lista
        if charactersList.isEmpty {
            // A lista de personagens está vazia, faz uma chamada à API para carregar os dados
            requestApi()
        } else {
            // A lista de personagens já está carregada, passa para a camada do listCharacterCoordinator
            listCharacterCoordinator?.goesToDetailCharacter(result: charactersList[index])
        }
    }
   
}
