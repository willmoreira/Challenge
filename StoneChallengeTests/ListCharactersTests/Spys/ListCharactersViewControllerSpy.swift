//
//  ListCharactersViewControllerSpy.swift
//  StoneChallengeTests
//
//  Created by William on 17/07/23.
//

import Foundation

@testable import StoneChallenge

class ListCharactersViewControllerSpy: ListCharactersViewControllerDelegate {

    var updateListCharacterCalled = false
    var withoutInternetCalled = false

    func updateListCharacterDelegate() {
        self.updateListCharacterCalled = true
    }

    func withoutInternet() {
        self.withoutInternetCalled = false
    }
}
