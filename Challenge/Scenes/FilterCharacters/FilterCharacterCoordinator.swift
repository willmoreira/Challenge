import UIKit

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
        viewController.viewModel = viewModel
        return viewController
    }
}
