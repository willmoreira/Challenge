//
//  ListCharactersServiceSpy.swift
//  StoneChallengeTests
//
//  Created by William on 17/07/23.
//

import Foundation

@testable import StoneChallenge

class ListCharactersServiceSpy: ListCharactersServiceProtocol {

    var requestResult: Result<CharactersResponse, ApiError>?
    
    func doRequestListCharacters(page: Int,
                                 name: String?,
                                 status: String?,
                                 completion: @escaping (Result<CharactersResponse, ApiError>) -> Void) {
        guard let spyRequestResult = requestResult else {
            return completion(.failure(.unknown))
        }
        completion(spyRequestResult)
    }
}
