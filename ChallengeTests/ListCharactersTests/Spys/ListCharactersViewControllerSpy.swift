//
//  ListCharactersViewControllerSpy.swift
//  ChallengeTests
//
//  Created by William on 17/07/23.
//

import Foundation

@testable import Challenge

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
