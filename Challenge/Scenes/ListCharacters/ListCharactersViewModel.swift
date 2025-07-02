import Foundation
import SystemConfiguration

protocol ListCharactersViewControllerDelegate: AnyObject {
    func updateListCharacterDelegate()
    func withoutInternet()
}

protocol ListCharactersViewModelNavigation {
    func goesToFilterCharacter()
    func goesToDetailCharacter(_ index: Int)
}

protocol ListCharactersViewModelDataSource {
    func requestCharacterList()
    func requestCharacterListInitial(name: String, status: String)
    func characterListSize() -> Int
    func getCharacter(index: Int) -> CharacterCellViewModel
}

class ListCharactersViewModel: ListCharactersViewModelDataSource, ListCharactersViewModelNavigation {

    // MARK: - Properties

    weak var delegate: ListCharactersViewControllerDelegate?
    var coordinator: ListCharactersCoordinatorDelegate?

    private let service: ListCharactersServiceProtocol
    private var pagination = Pagination()
    private var name: String?
    private var status: String?
    private var charactersList: [CharacterCellViewModel] = []
    private var isLoadNextPageInProgress = false

    // MARK: - Initialization

    init(service: ListCharactersServiceProtocol = ListCharactersService()) {
        self.service = service
    }

    // MARK: - Public Methods

    func requestCharacterList() {

        if isInternetAvailable() {
            guard pagination.currentPage <= pagination.totalPages, !isLoadNextPageInProgress else { return }
            isLoadNextPageInProgress = true
            service.doRequestListCharacters(page: pagination.currentPage, name: name, status: status) { result in
                switch result {
                case let .success(characterListViewModel):
                    self.pagination.currentPage += 1
                    self.pagination.totalPages = characterListViewModel.info?.pages ?? 1
                    self.charactersList.append(contentsOf: characterListViewModel.characters)
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
        pagination.currentPage = 1
        pagination.totalPages = 1
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

    func getCharacter(index: Int) -> CharacterCellViewModel {
        return charactersList[index]
    }
}
