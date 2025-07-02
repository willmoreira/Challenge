//
//  FilterCharacterViewModelTests.swift
//  StoneChallengeTests
//
//  Created by William on 18/07/23.
//

import XCTest
@testable import StoneChallenge

class FilterCharacterViewModelTests: XCTestCase {

    // MARK: - Properties

    var sut: FilterCharacterViewModel!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        sut = FilterCharacterViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testFilterCharacters() {

        // Given
        let delegateSpy = FilterCharacterViewModelActionsDelegateSpy()
        sut.passDelegateFilterCharacter(delegate: delegateSpy)

        // When
        sut.filterCharacters(name: "John", status: "Alive")

        // Then
        XCTAssertEqual(delegateSpy.updatedName, "John")
        XCTAssertEqual(delegateSpy.updatedStatus, "Alive")
    }
}
