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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewController = FilterCharacterViewController()
        let viewModel = FilterCharacterViewModel()
        viewModel.filterCharacterCoordinator = self
        viewController.viewModel = viewModel
        return viewController
    }
    
}
extension FilterCharacterCoordinator: FilterCharacterCoordinatorDelegate {
    
}
