//
//  ListCharactersService.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit

class ListCharactersService {
    
    // MARK: - Public Methods
    
    func doRequestListCharacters(page: Int, name: String? = nil, status: String? = nil, completion: @escaping (Result<CharactersResponse, ApiError>) -> Void) {
        
        let nameValid = name ?? ""
        let statusValid = status ?? ""

        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)&name=\(nameValid)&status=\(statusValid)"
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
