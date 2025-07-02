import XCTest
@testable import Challenge

class DetailCharacterCoordinatorTests: XCTestCase {

    func testInitWithNavigationController() {
        // Given
        let navigationController = UINavigationController()

        // When
        let coordinator = DetailCharacterCoordinator(navigationController: navigationController)

        // Then
        XCTAssertEqual(coordinator.navigationController, navigationController)
    }

    func testStart() {
        // Given
        let coordinator = DetailCharacterCoordinator()

        // When
        let viewController = coordinator.start()

        // Then
        XCTAssertTrue(viewController is DetailCharacterViewController)
    }
}
