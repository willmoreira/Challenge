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
        viewModel.coordinator = self
        viewModel.viewController = viewController
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ListCharactersCoordinator: ListCharactersCoordinatorDelegate {
    
    // MARK: - ListCharactersCoordinatorDelegate

    func goesToFilterCharacter() {
        let filterCharacterCoordinator = FilterCharacterCoordinator()
        guard let filterCharacterViewController = filterCharacterCoordinator.start() as? FilterCharacterViewController else { return }
        guard let navigationControllerLast = navigationController.viewControllers.last as? FilterCharacterViewModelActionsDelegate else { return }
        filterCharacterViewController.viewModel?.passDelegateFilterCharacter(delegate: navigationControllerLast)
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(filterCharacterViewController, animated: true)
    }
    
    func goesToDetailCharacter(result: CharactersResponse.Result) {
        let detailCharacterCoordinator = DetailCharacterCoordinator()
        guard let detailCharacterViewController = detailCharacterCoordinator.start() as? DetailCharacterViewController else { return }
        detailCharacterViewController.character = result
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(detailCharacterViewController, animated: true)
    }
}

