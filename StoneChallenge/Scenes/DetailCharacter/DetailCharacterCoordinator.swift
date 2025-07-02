//
//  DetailCharacterCoordinator.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

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
        return viewController
    }
}
