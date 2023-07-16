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
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var viewModel: ListCharactersViewModelDelegate?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        configureTableView()
        viewModel?.requestCharacterList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    // MARK: - Private Methods
    
    private func setupBackButton() {
        navigationItem.title = "Lista de Personagens"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCharacterCells.self, forCellReuseIdentifier: "TableViewCharacterCells")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
    }
    
    // MARK: - Actions
    
    @objc private func filterButtonTapped() {
        goesToFilterCharacter()
    }
    
    // MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - tableHeight {
            loadNextPage()
            tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCharacterCells", for: indexPath) as? TableViewCharacterCells else { return UITableViewCell() }
        if let character = viewModel?.getCharacter(index: indexPath.row) {
            cell.setupCell(name: character.name, urlImage: character.image)
        }
        return cell
    }
}

// MARK: - ListCharactersCoordinatorDelegate

extension ListCharactersViewController: ListCharactersCoordinatorDelegate{
    
    func goesToDetailCharacter(result: CharactersResponse.Result) {
        //TODO: Deixa aqui mesmo?
    }
    
    func goesToFilterCharacter() {
        viewModel?.goesToFilterCharacter()
    }
}

// MARK: - ListCharactersActionsDelegate

extension ListCharactersViewController: ListCharactersActionsDelegate {
    
    func updateListCharacter() {
        tableView.reloadData()
    }
}

