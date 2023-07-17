//
//  FilterCharacterCoordinator.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

protocol FilterCharacterCoordinatorDelegate: AnyObject {

}

class FilterCharacterCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
        
    // MARK: - Initialization
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    func start() -> UIViewController {
        let viewController = FilterCharacterViewController()
        let viewModel = FilterCharacterViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        return viewController
    }
    
}

extension FilterCharacterCoordinator: FilterCharacterCoordinatorDelegate {
  
}
