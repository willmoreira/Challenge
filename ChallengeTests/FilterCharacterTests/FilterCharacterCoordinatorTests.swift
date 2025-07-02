//
//  FilterCharacterCoordinator.swift
//  ChallengeTests
//
//  Created by William on 18/07/23.
//

import XCTest
@testable import Challenge

class FilterCharacterCoordinatorTests: XCTestCase {

    func testInitWithNavigationController() {
        // Given
        let navigationController = UINavigationController()

        // When
        let sut = FilterCharacterCoordinator(navigationController: navigationController)

        // Then
        XCTAssertEqual(sut.navigationController, navigationController)
    }

    func testStart() {
        // Given
        let sut = FilterCharacterCoordinator()

        // When
        let viewController = sut.start()

        // Then
        XCTAssertTrue(viewController is FilterCharacterViewController)
    }
}
