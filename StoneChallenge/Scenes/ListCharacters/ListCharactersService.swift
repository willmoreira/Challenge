//
//  ListCharactersService.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

enum ApiError: Error {
    case couldNotConnectToServer
    case noInternet
    case decode
    case invalidURL
    case noResponse
    case unathorized
    case unexpectedStatusCode(statusCode: Int, errorMessage: String?)
    case unknown
}

class ListCharactersService {
    
    // MARK: - Public Methods
    
    func doRequestListCharacters(page: Int, completion: @escaping (Result<CharactersResponse, ApiError>) -> Void) {
        
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"
        let session = URLSession.shared
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown))
                print("Erro: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                completion(.failure(.noResponse))
                print("Não há dados na resposta")
                return
            }
            do {
                let decoder = JSONDecoder()
                let filmModel = try decoder.decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(filmModel))
                }
            } catch {
                completion(.failure(.decode))
            }
        }
        task.resume()
    }
}
