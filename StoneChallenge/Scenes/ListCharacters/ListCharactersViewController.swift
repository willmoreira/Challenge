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
    
    private lazy var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.isHidden = true
        view.alpha = 0.5
        return view
    }()
    
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
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        configureTableView()
        configureSquareView()
        activityIndicator.startAnimating()
        viewModel?.requestCharacterListInitial(name: "", status: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
    // MARK: - Private Methods
    
    private func configureSquareView() {
        view.addSubview(squareView)
        squareView.translatesAutoresizingMaskIntoConstraints = false
        
        squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        squareView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        squareView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        squareView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setupActivityIndicator()
    }
    
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
        viewModel?.goesToFilterCharacter()
    }
    
    // MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - tableHeight {
            squareView.isHidden = false
            activityIndicator.startAnimating()
            loadNextPage()
        }
    }
    
    // MARK: - Load Next Page
    
    func loadNextPage() {
        viewModel?.requestCharacterList()
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        squareView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
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

// MARK: - ListCharactersViewControllerDelegate

extension ListCharactersViewController: ListCharactersViewControllerDelegate {
    func updateListCharacter() {
        activityIndicator.stopAnimating()
        squareView.isHidden = true
        if viewModel?.characterListSize() == 0 {
            //chama o alert
        }
        tableView.reloadData()
    }
}

extension ListCharactersViewController: FilterCharacterViewModelActionsDelegate {
    func updateListCharacter(name: String, status: String) {
        viewModel?.requestCharacterListInitial(name: name, status: status)
    }
}
