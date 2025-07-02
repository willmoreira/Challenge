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
        completion: @escaping (Result<CharacterListViewModel, ApiError>) -> Void
    ) {
        let nameValid = name ?? ConfigurationStrings.emptyString
        let statusValid = status ?? ConfigurationStrings.emptyString
        let urlString = """
        https://rickandmortyapi.com/api/character/?page=\(page)&name=\(nameValid)&status=\(statusValid)
        """

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = ConfigurationStrings.getMethod

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(ConfigurationStrings.ErrorResponse + error.localizedDescription)
                completion(.failure(.unknown))
                return
            }

            guard let data = data else {
                print(ConfigurationStrings.MessageErrorData)
                completion(.failure(.noResponse))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CharactersResponse.self, from: data)

                let listViewModel = response.mapToCharacterListViewModel()
                DispatchQueue.main.async {
                    completion(.success(listViewModel))
                }
            } catch {
                completion(.failure(.decode))
            }
        }

        task.resume()
    }
}
