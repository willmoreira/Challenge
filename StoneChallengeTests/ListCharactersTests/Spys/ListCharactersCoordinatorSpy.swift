//
//  ListCharactersCoordinatorSpy.swift
//  StoneChallengeTests
//
//  Created by William on 17/07/23.
//


import Foundation

@testable import StoneChallenge

class ListCharactersCoordinatorSpy: ListCharactersCoordinatorDelegate {
    
    var goesToFilterCharacterCalled = false
    var goesToDetailCharacterCalled = false
    var goesToDetailCharacterResult: CharactersResponse.Result?

    func goesToFilterCharacter() {
        self.goesToFilterCharacterCalled = true
    }
    
    func goesToDetailCharacter(result: CharactersResponse.Result) {
        self.goesToDetailCharacterCalled = true
        self.goesToDetailCharacterResult = result
    }
}
