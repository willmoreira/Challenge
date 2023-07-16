//
//  ListCharactersCoordinator.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

protocol ListCharactersCoordinatorDelegate: AnyObject {
    func goesToFilterCharacter()
    func goesToDetailCharacter(result: CharactersResponse.Result)
}

class ListCharactersCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator Methods
    
    func start() -> UIViewController {
        let viewController = ListCharactersViewController()
        let viewModel = ListCharactersViewModel()
        viewModel.listCharacterCoordinator = self
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ListCharactersCoordinator: ListCharactersCoordinatorDelegate {
    
    // MARK: - ListCharactersCoordinatorDelegate
    
    func goesToFilterCharacter() {
        let filterCharacterCoordinator = FilterCharacterCoordinator()
        let filterCharacterViewController = filterCharacterCoordinator.start() as! FilterCharacterViewController
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(filterCharacterViewController, animated: true)
    }
    
    func goesToDetailCharacter(result: CharactersResponse.Result) {
        let detailCharacterCoordinator = DetailCharacterCoordinator()
        let detailCharacterViewController = detailCharacterCoordinator.start() as! DetailCharacterViewController
        detailCharacterViewController.character = result
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(detailCharacterViewController, animated: true)
    }
}

