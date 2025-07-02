import Foundation
@testable import Challenge

class ObjectSeeds {
    static let responseCharacterWithTwoCharacter = CharacterListViewModel(
        characters: [character1, character2],
        info: CharactersResponse.Info(
            count: 1,
            pages: 2,
            next: "",
            prev: "")
    )

    static let responseCharacter = CharacterListViewModel(
        characters: [character1],
        info: CharactersResponse.Info(
            count: 1,
            pages: 2,
            next: "",
            prev: "")
    )

    static let responseCharacterEmpytResults = CharacterListViewModel(
        characters: [],
        info: CharactersResponse.Info(
            count: 1,
            pages: 2,
            next: "",
            prev: "")
    )

    static let character1 = CharacterCellViewModel(
        id: 1,
        name: "",
        imageURL: "",
        status: CharactersResponse.Status.dead.rawValue,
        species: "",
        origin: "",
        location: ""
    )

    static let character2 = CharacterCellViewModel(
        id: 2,
        name: "",
        imageURL: "",
        status: CharactersResponse.Status.alive.rawValue,
        species: "",
        origin: "",
        location: ""
    )
}
