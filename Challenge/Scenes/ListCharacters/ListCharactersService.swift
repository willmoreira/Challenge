import UIKit

protocol ListCharactersServiceProtocol {
    func doRequestListCharacters(
        page: Int, name: String?,
        status: String?,
        completion: @escaping (Result<CharacterListViewModel, ApiError>) -> Void
    )
}

class ListCharactersService: ListCharactersServiceProtocol {

    // MARK: - Public Methods

    func doRequestListCharacters(
        page: Int,
        name: String? = nil,
        status: String? = nil,
        completion: @escaping (Result<CharacterListViewModel, ApiError>
        ) -> Void
    ) {
        let nameValid = name ?? ConfigurationStrings.emptyString
        let statusValid = status ?? ConfigurationStrings.emptyString
        let urlString = """
        https://rickandmortyapi.com/api/character/?page=\(page)&name=\(nameValid)&status=\(statusValid)
        """
        let session = URLSession.shared

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = ConfigurationStrings.getMethod

        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.unknown))
                print(ConfigurationStrings.ErrorResponse + "\(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(.noResponse))
                print(ConfigurationStrings.MessageErrorData)
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CharactersResponse.self, from: data)

                guard let results = response.results else {
                    completion(.failure(.noResponse))
                    return
                }

                let viewModels: [CharacterCellViewModel] = results.compactMap {
                    return CharacterCellViewModel(
                        id: $0.id,
                        name: $0.name,
                        imageURL: $0.image,
                        status: $0.status.rawValue,
                        species: $0.species,
                        origin: $0.origin.name,
                        location: $0.location.name
                    )
                }

                let listViewModel = CharacterListViewModel(
                    characters: viewModels,
                    info: response.info
                )

                DispatchQueue.main.async { completion(.success(listViewModel)) }
            } catch {
                completion(.failure(.decode))
            }
        }
        task.resume()
    }
}
