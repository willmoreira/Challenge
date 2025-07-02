//
//  ListCharactersCoordinator.swift
//  Challenge
//
//  Created by William on 14/07/23.
//

import UIKit

protocol ListCharactersCoordinatorDelegate: AnyObject {
    func goesToFilterCharacter()
    func goesToDetailCharacter(result: CharacterCellViewModel)
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
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ListCharactersCoordinator: ListCharactersCoordinatorDelegate {

    // MARK: - ListCharactersCoordinatorDelegate

    func goesToFilterCharacter() {
        let filterCharacterCoordinator = FilterCharacterCoordinator()
        guard let filterCharacterViewController = filterCharacterCoordinator.start()
                as? FilterCharacterViewController else { return }
        guard let navigationControllerLast = navigationController.viewControllers.last
                as? FilterCharacterViewModelActionsDelegate else { return }
        filterCharacterViewController.viewModel?.passDelegateFilterCharacter(delegate: navigationControllerLast)
        let backButton = UIBarButtonItem(title: ProjectStrings.back.localized, style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(filterCharacterViewController, animated: true)
    }

    func goesToDetailCharacter(result: CharacterCellViewModel) {
        let detailCharacterCoordinator = DetailCharacterCoordinator()
        guard let detailCharacterViewController = detailCharacterCoordinator.start()
                as? DetailCharacterViewController else { return }
        detailCharacterViewController.character = result
        let backButton = UIBarButtonItem(title: ProjectStrings.back.localized, style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(detailCharacterViewController, animated: true)
    }
}
