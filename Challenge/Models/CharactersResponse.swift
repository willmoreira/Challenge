import Foundation

// MARK: - Welcome

struct CharactersResponse: Codable {
    let info: Info?
    let results: [Result]?
    let error: String?
}

extension CharactersResponse {

    // MARK: - Info

    struct Info: Codable {
        let count, pages: Int
        let next, prev: String?
    }

    // MARK: - Result

    struct Result: Codable {
        let id: Int
        let name: String
        let status: Status
        let species: String
        let type: String
        let gender: Gender
        let origin, location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }

    // MARK: Enum - Gender

    enum Gender: String, Codable {
        case female = "Female"
        case genderless = "Genderless"
        case male = "Male"
        case unknown = "unknown"
    }

    // MARK: - Location

    struct Location: Codable {
        let name: String
        let url: String
    }

    // MARK: - Status

    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}
