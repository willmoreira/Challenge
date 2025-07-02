import Foundation

struct CharacterCellViewModel {

    let id: Int
    let name: String
    let imageURL: String
    let status: String
    let species: String
    let origin: String
    let location: String
}

extension CharactersResponse {

    func mapToCharacterListViewModel() -> CharacterListViewModel {
        let viewModels: [CharacterCellViewModel] = results?.compactMap {
            CharacterCellViewModel(
                id: $0.id,
                name: $0.name,
                imageURL: $0.image,
                status: $0.status.rawValue,
                species: $0.species,
                origin: $0.origin.name,
                location: $0.location.name
            )
        } ?? []

        return CharacterListViewModel(
            characters: viewModels,
            info: info
        )
    }
}
