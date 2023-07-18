//
//  DetailCharacterViewModel.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import Foundation

protocol DetailCharacterViewModelActionsDelegate: AnyObject {

}

protocol DetailCharacterViewModelDelegate: AnyObject {
  
}

class DetailCharacterViewModel: DetailCharacterViewModelDelegate {
    
    // MARK: - Properties

    weak var delegate: DetailCharacterViewModelActionsDelegate?
    var coordinator: DetailCharacterCoordinatorDelegate?
}
