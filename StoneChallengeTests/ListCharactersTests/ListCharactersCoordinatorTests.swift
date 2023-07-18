//
//  ListCharactersCoordinatorTests.swift
//  StoneChallengeTests
//
//  Created by William on 17/07/23.
//

import XCTest

@testable import StoneChallenge

class FilterCharacterCoordinatorTests: XCTestCase {

    // MARK: - Properties
    var sut: FilterCharacterCoordinator!
    var navigationController: UINavigationController!
    
    // MARK: - Test Lifecycle
    
    override func setUpWithError() throws {
        navigationController = UINavigationController()
        sut = FilterCharacterCoordinator(navigationController: navigationController)
    }

    override func tearDownWithError() throws {
        navigationController = nil
        sut = nil
    }
    
    // MARK: - Tests
    
    func testStart_ReturnsCorrectViewController() {
        // Given
        let expectedViewController = FilterCharacterViewController.self
        
        // When
        let viewController = sut.start()
        
        // Then
        XCTAssertTrue(viewController.isKind(of: expectedViewController), "O coordenador deve retornar a instância correta de FilterCharacterViewController.")
    }
}
