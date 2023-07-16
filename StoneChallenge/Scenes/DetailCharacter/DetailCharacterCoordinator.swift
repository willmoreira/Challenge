//
//  DetailCharacterCoordinator.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

protocol DetailCharacterCoordinatorDelegate: AnyObject {

}

class DetailCharacterCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator Methods
    
    func start() -> UIViewController {
        let viewController = DetailCharacterViewController()
        let viewModel = DetailCharacterViewModel()
        viewModel.detailCharacterCoordinator = self
        viewController.viewModel = viewModel
        return viewController
    }
}

extension DetailCharacterCoordinator: DetailCharacterCoordinatorDelegate {

}
