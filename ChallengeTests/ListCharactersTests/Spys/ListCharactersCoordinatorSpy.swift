import Foundation
@testable import Challenge

class ListCharactersCoordinatorSpy: ListCharactersCoordinatorDelegate {

    var goesToFilterCharacterCalled = false
    var goesToDetailCharacterCalled = false
    var goesToDetailCharacterResult: CharacterCellViewModel?

    func goesToFilterCharacter() {
        self.goesToFilterCharacterCalled = true
    }

    func goesToDetailCharacter(result: CharacterCellViewModel) {
        self.goesToDetailCharacterCalled = true
        self.goesToDetailCharacterResult = result
    }
}
