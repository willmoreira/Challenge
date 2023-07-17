//
//  ListCharactersViewModelTest.swift
//  StoneChallengeTests
//
//  Created by William on 17/07/23.
//

import XCTest

@testable import StoneChallenge

class ListCharactersViewModelTest: XCTestCase {

    var sut: ListCharactersViewModel!
    var serviceSpy: ListCharactersServiceSpy!
    
    override func setUp() {
        serviceSpy = ListCharactersServiceSpy()
        sut = ListCharactersViewModel(service: serviceSpy)
        sut.coordinator
    }
    
    override func tearDown() {
        serviceSpy = nil
        sut = nil
    }
    
    func testdoRequestListCharactersSucces() {
        
        // given
        let responseCharacter = CharactersResponse(info: nil,
                                                   results: nil,
                                                   error: nil)
        
        serviceSpy.requestResult = .success(responseCharacter)
        
        
        // when
        sut.requestCharacterList()
        
        // then
        
    }
}
