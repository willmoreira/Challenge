//
//  ListCharactersViewModelTest.swift
//  ChallengeTests
//
//  Created by William on 17/07/23.
//

import XCTest

@testable import Challenge

class ListCharactersViewModelTest: XCTestCase {

    var sut: ListCharactersViewModel!
    var serviceSpy: ListCharactersServiceSpy!
    var coordinatorSpy: ListCharactersCoordinatorSpy!
    var viewControllerSpy: ListCharactersViewControllerSpy!

    override func setUp() {
        serviceSpy = ListCharactersServiceSpy()
        coordinatorSpy = ListCharactersCoordinatorSpy()
        viewControllerSpy = ListCharactersViewControllerSpy()
        sut = ListCharactersViewModel(service: serviceSpy)
        sut.coordinator = coordinatorSpy
        sut.delegate = viewControllerSpy
    }

    override func tearDown() {
        serviceSpy = nil
        sut = nil
        coordinatorSpy = nil
        viewControllerSpy = nil
    }

    func testdoRequestListCharactersSucces() {

        // given
        let responseCharacter = ObjectSeeds.responseCharacter

        serviceSpy.requestResult = .success(responseCharacter)

        // when
        sut.requestCharacterList()

        // then
        XCTAssertTrue(viewControllerSpy.updateListCharacterCalled)
    }

    func testRequestCharacterListFailure() {

        // given
        serviceSpy.requestResult = .failure(.decode)

        // when
        sut.requestCharacterList()

        // then
        XCTAssertEqual(sut.characterListSize(), 0, "charactersList should be empty after a failed request.")

    }

    func testRequestCharacterListInitial() {

        // given
        let responseCharacter = ObjectSeeds.responseCharacter
        serviceSpy.requestResult = .success(responseCharacter)

        // when
        sut.requestCharacterListInitial(name: "TestName", status: "TestStatus")

        // then
        XCTAssertEqual(sut.characterListSize(), 1, """
        charactersList should have one item after a successful initial request.
        """
        )
    }

    func testGoesToDetailCharacter() {

        // given
        let responseCharacter = ObjectSeeds.responseCharacter

        serviceSpy.requestResult = .success(responseCharacter)
        sut.requestCharacterListInitial(name: "", status: "")

        // when
        sut.goesToDetailCharacter(0)

        // then
        XCTAssertTrue(coordinatorSpy.goesToDetailCharacterCalled, """
        The coordinator function goesToDetailCharacter(result:) should be called.
        """
        )
    }

    func testGoesToDetailCharacterEmptyList() {

        // given
        let responseCharacter = ObjectSeeds.responseCharacterEmpytResults
        serviceSpy.requestResult = .success(responseCharacter)
        sut.requestCharacterListInitial(name: "", status: "")

        // when
        sut.goesToDetailCharacter(0)

        // then
        XCTAssertFalse(coordinatorSpy.goesToDetailCharacterCalled, """
        The coordinator function goesToDetailCharacter(result:) should be called.
        """
        )
    }

    func testGoesToFilterCharacter() {

        // given
        // when
        sut.goesToFilterCharacter()

        // then
        XCTAssertTrue(coordinatorSpy.goesToFilterCharacterCalled, """
        The coordinator function goesToFilterCharacter() should be called.
        """
        )
    }

    func testGetCharacter() {

        // given
        let character1 = ObjectSeeds.character1
        let character2 = ObjectSeeds.character2
        let responseCharacter = ObjectSeeds.responseCharacterWithTwoCharacter
        serviceSpy.requestResult = .success(responseCharacter)
        sut.requestCharacterListInitial(name: "", status: "")

        // when
        let retrievedCharacter1 = sut.getCharacter(index: 0)
        let retrievedCharacter2 = sut.getCharacter(index: 1)

        // then
        XCTAssertEqual(retrievedCharacter1.id, character1.id, "The method should return the character at id 1.")
        XCTAssertEqual(retrievedCharacter2.id, character2.id, "The method should return the character at id 2.")
    }
}
