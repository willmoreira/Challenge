//
//  ListCharactersViewController.swift
//  StoneChallenge
//
//  Created by William on 14/07/23.
//

import UIKit
import SDWebImage

class ListCharactersViewController: UIViewController {

    // MARK: - Properties

    private lazy var btnFilter: UIButton = {
        let btnFilter = UIButton(type: .custom)
        btnFilter.setImage(UIImage(named: ConfigurationStrings.filter), for: .normal)
        btnFilter.accessibilityIdentifier = ConfigurationStrings.btnFilter
        btnFilter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return btnFilter
    }()

    private lazy var btnReloadCharacters: UIButton = {
        let btnReloadCharacters = UIButton(type: .system)
        btnReloadCharacters.setTitle(ProjectStrings.reloadList.localized, for: .normal)
        btnReloadCharacters.setTitleColor(.black, for: .normal)
        btnReloadCharacters.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btnReloadCharacters.layer.borderWidth = 1.0
        btnReloadCharacters.layer.borderColor = UIColor.black.cgColor
        btnReloadCharacters.backgroundColor = UIColor(red: 245/255.0, green: 237/255.0, blue: 117/255.0, alpha: 1.0)
        btnReloadCharacters.addTarget(self, action: #selector(reloadCharactersButtonTapped), for: .touchUpInside)
        btnReloadCharacters.isHidden = true
        btnReloadCharacters.clipsToBounds = true
        return btnReloadCharacters
    }()

    private lazy var tblVwListCharacter: UITableView = {
        let tblVwListCharacter = UITableView()
        tblVwListCharacter.register(UITableViewCell.self, forCellReuseIdentifier: ConfigurationStrings.cellDefault)
        tblVwListCharacter.accessibilityIdentifier = ConfigurationStrings.tblVwListCharacter
        return tblVwListCharacter
    }()

    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()
    private var isToShowTheFirstCell = false

    var viewModel: ListCharactersViewModelDelegate?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        setupReloadCharacterButton()
        setupActivityIndicator()
        activityIndicator.startAnimating()
        viewModel?.requestCharacterListInitial(name: ConfigurationStrings.emptyString,
                                               status: ConfigurationStrings.emptyString)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnReloadCharacters.layer.cornerRadius = btnReloadCharacters.frame.height / 2
        btnReloadCharacters.clipsToBounds = true
    }

    // MARK: - Private Methods

    private func setupBackButton() {
        navigationItem.title = ProjectStrings.listCharacter.localized
    }

    private func setupTableView() {
        tblVwListCharacter.delegate = self
        tblVwListCharacter.dataSource = self
        tblVwListCharacter.register(
            TableViewCharacterCells.self,
            forCellReuseIdentifier: ConfigurationStrings.tableViewCharacterCells
        )
        tblVwListCharacter.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)

        view.addSubview(tblVwListCharacter)
        tblVwListCharacter.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tblVwListCharacter.topAnchor.constraint(equalTo: view.topAnchor),
            tblVwListCharacter.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tblVwListCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tblVwListCharacter.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnFilter)
    }

    private func setupReloadCharacterButton() {
        btnReloadCharacters.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnReloadCharacters)

        NSLayoutConstraint.activate([
            btnReloadCharacters.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnReloadCharacters.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnReloadCharacters.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            btnReloadCharacters.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            btnReloadCharacters.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tblVwListCharacter.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tblVwListCharacter.centerYAnchor)
        ])
    }

    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ProjectStrings.titleOk.localized, style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Actions

    @objc private func filterButtonTapped() {
        viewModel?.goesToFilterCharacter()
    }

    @objc private func reloadCharactersButtonTapped() {
        btnReloadCharacters.isHidden = true
        viewModel?.requestCharacterListInitial(name: "", status: "")
    }

    @objc private func refreshTableView() {
        viewModel?.requestCharacterListInitial(name: "", status: "")
        btnReloadCharacters.isHidden = true
        refreshControl.endRefreshing()
    }

    // MARK: - Scroll View Delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableHeight = scrollView.frame.size.height

        if offsetY > contentHeight - tableHeight {
            loadNextPage()
        }
    }

    // MARK: - Load Next Page

    func loadNextPage() {
        viewModel?.requestCharacterList()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListCharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characterListSize() ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.goesToDetailCharacter(index)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ConfigurationStrings.tableViewCharacterCells,
            for: indexPath
        ) as? TableViewCharacterCells else { return UITableViewCell() }
        if let character = viewModel?.getCharacter(index: indexPath.row) {
            cell.setupCell(name: character.name, urlImage: character.image)
        }
        return cell
    }
}

// MARK: - ListCharactersViewControllerDelegate

extension ListCharactersViewController: ListCharactersViewControllerDelegate {
    func withoutInternet() {
        activityIndicator.stopAnimating()
        btnReloadCharacters.isHidden = false
        showAlert(title: ProjectStrings.titleAlertWithoutInternet.localized,
                  message: ProjectStrings.messageAlertWithoutInternet.localized)
    }

    func updateListCharacterDelegate() {
        activityIndicator.stopAnimating()
        tblVwListCharacter.reloadData()

        if viewModel?.characterListSize() == 0 {
            btnReloadCharacters.isHidden = false
            showAlert(
                title: ProjectStrings.titleSearchWithoutResult.localized,
                message: ProjectStrings.messageNoResultsFound.localized
            )
        } else if isToShowTheFirstCell {
            self.isToShowTheFirstCell = false
            let indexPath = IndexPath(row: 0, section: 0)
            self.tblVwListCharacter.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

// MARK: - FilterCharacterViewModelActionsDelegate

extension ListCharactersViewController: FilterCharacterViewModelActionsDelegate {
    func updateListCharacter(name: String, status: String) {
        activityIndicator.startAnimating()
        isToShowTheFirstCell = true
        viewModel?.requestCharacterListInitial(name: name, status: status)
    }
}
