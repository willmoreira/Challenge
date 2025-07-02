import Foundation
@testable import Challenge

class ListCharactersServiceSpy: ListCharactersServiceProtocol {
    var requestResult: Result<CharacterListViewModel, ApiError>?

    func doRequestListCharacters(
        page: Int,
        name: String?,
        status: String?,
        completion: @escaping (
            Result<Challenge.CharacterListViewModel,
                               Challenge.ApiError>
        ) -> Void) {
            guard let spyRequestResult = requestResult else {
                return completion(.failure(.unknown))
            }
            completion(spyRequestResult)
        }
}
