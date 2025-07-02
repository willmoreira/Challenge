//
//  FilterCharacterViewModelActionsDelegateSpy.swift
//  StoneChallengeTests
//
//  Created by William on 18/07/23.
//

import Foundation
@testable import StoneChallenge
// swiftlint:disable:next type_name
class FilterCharacterViewModelActionsDelegateSpy: FilterCharacterViewModelActionsDelegate {
    var updatedName: String?
    var updatedStatus: String?

    func updateListCharacter(name: String, status: String) {
        updatedName = name
        updatedStatus = status
    }
}
