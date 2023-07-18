//
//  TESTE.swift
//  StoneChallengeTests
//
//  Created by William on 18/07/23.
//

import XCTest
@testable import StoneChallenge

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
