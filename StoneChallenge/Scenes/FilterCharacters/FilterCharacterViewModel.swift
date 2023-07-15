//
//  FilterCharacterViewModel.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import Foundation

protocol FilterCharacterViewModelActionsDelegate: AnyObject {

}

protocol FilterCharacterViewModelDelegate: AnyObject {
    func filterCharacters(with option: String)
}


class FilterCharacterViewModel: FilterCharacterViewModelDelegate {
  
    weak var delegate: FilterCharacterViewModelActionsDelegate?
    var filterCharacterCoordinator: FilterCharacterCoordinatorDelegate?
    
    func filterCharacters(with option: String) {
        
    }
}
