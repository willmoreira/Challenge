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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
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
