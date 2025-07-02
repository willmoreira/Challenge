//
//  ObjectSeeds.swift
//  ChallengeTests
//
//  Created by William on 18/07/23.
//

import Foundation
@testable import Challenge

class ObjectSeeds {
    static let responseCharacterWithTwoCharacter = CharactersResponse(
        info: CharactersResponse.Info(
            count: 1,
            pages: 1,
            next: "3",
            prev: "1"),
        results: [character1, character2],
        error: nil)

    static let responseCharacter = CharactersResponse(
        info: CharactersResponse.Info(
            count: 1,
            pages: 2,
            next: "",
            prev: ""),
        results: [character1],
        error: nil)

    static let responseCharacterEmpytResults = CharactersResponse(
        info: CharactersResponse.Info(
            count: 1,
            pages: 2,
            next: "",
            prev: ""),
        results: [],
        error: nil)

    static let character1 = CharactersResponse.Result(
        id: 1,
        name: "",
        status: CharactersResponse.Status.dead,
        species: "",
        type: "",
        gender: CharactersResponse.Gender.female,
        origin: CharactersResponse.Location(name: "", url: ""),
        location: CharactersResponse.Location(name: "", url: ""),
        image: "",
        episode: [""],
        url: "",
        created: "")

    static let character2 = CharactersResponse.Result(
        id: 2,
        name: "",
        status: CharactersResponse.Status.dead,
        species: "",
        type: "",
        gender: CharactersResponse.Gender.female,
        origin: CharactersResponse.Location(name: "", url: ""),
        location: CharactersResponse.Location(name: "", url: ""),
        image: "",
        episode: [""],
        url: "",
        created: "")
}
