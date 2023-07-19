//
//  ListCharactersService.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

protocol ListCharactersServiceProtocol {
    func doRequestListCharacters(page: Int, name: String?, status: String?, completion: @escaping (Result<CharactersResponse, ApiError>) -> Void)
}

class ListCharactersService: ListCharactersServiceProtocol {
    
    // MARK: - Public Methods
    
    func doRequestListCharacters(page: Int, name: String? = nil, status: String? = nil, completion: @escaping (Result<CharactersResponse, ApiError>) -> Void) {
        
        let nameValid = name ?? ConfigurationStrings.emptyString
        let statusValid = status ?? ConfigurationStrings.emptyString
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)&name=\(nameValid)&status=\(statusValid)"
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
                let result = try decoder.decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.decode))
            }
        }
        task.resume()
    }
}
