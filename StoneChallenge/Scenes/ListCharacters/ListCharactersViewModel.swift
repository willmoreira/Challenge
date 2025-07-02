//
//  ListCharactersViewModel.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import Foundation
import SystemConfiguration

protocol ListCharactersViewControllerDelegate: AnyObject {
    func updateListCharacterDelegate()
    func withoutInternet()
}

protocol ListCharactersViewModelDelegate: AnyObject {
    func goesToFilterCharacter()
    func goesToDetailCharacter(_ index: Int)
    func requestCharacterList()
    func requestCharacterListInitial(name: String, status: String)
    func characterListSize() -> Int
    func getCharacter(index: Int) -> CharactersResponse.Result
}

class ListCharactersViewModel: ListCharactersViewModelDelegate {

    // MARK: - Properties

    weak var delegate: ListCharactersViewControllerDelegate?
    var coordinator: ListCharactersCoordinatorDelegate?

    private let service: ListCharactersServiceProtocol
    private var name: String?
    private var status: String?
    private var page: Int = 1
    private var totalPages: Int = 1
    private var charactersList: [CharactersResponse.Result] = []
    private var isLoadNextPageInProgress = false

    // MARK: - Initialization

    init(service: ListCharactersServiceProtocol = ListCharactersService()) {
        self.service = service
    }

    // MARK: - Public Methods

    func requestCharacterList() {

        if isInternetAvailable() {
            guard page <= totalPages, !isLoadNextPageInProgress else { return }
            isLoadNextPageInProgress = true
            service.doRequestListCharacters(page: page, name: name, status: status) { result in
                switch result {
                case let .success(charactersResponse):
                    self.page += 1
                    if let charactersResponseInfo = charactersResponse.info,
                       let charactersResponseResults = charactersResponse.results {
                        self.totalPages = charactersResponseInfo.pages
                        self.charactersList.append(contentsOf: charactersResponseResults)
                    }
                    self.delegate?.updateListCharacterDelegate()
                    self.isLoadNextPageInProgress = false
                case .failure:
                    break
                }
            }
        } else {
            delegate?.withoutInternet()
        }
    }

    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }

    func requestCharacterListInitial(name: String, status: String) {
        page = 1
        totalPages = 1
        charactersList = []
        self.name = name
        self.status = status
        requestCharacterList()
    }

    func goesToFilterCharacter() {
        coordinator?.goesToFilterCharacter()
    }

    func goesToDetailCharacter(_ index: Int) {
        guard index < charactersList.count else { return }
        coordinator?.goesToDetailCharacter(result: charactersList[index])
    }

    func characterListSize() -> Int {
        return charactersList.count
    }

    func getCharacter(index: Int) -> CharactersResponse.Result {
        return charactersList[index]
    }
}
