//
//  SearchViewcontroller.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 30/10/22.
//

import Foundation
import UIKit

class SearchViewcontroller: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let pageTitle: String = "Recipes"
        static let recipesCellIdentifier: String = RecipesViewCell.reuseIdentifier
    }

    // MARK: - Properties

    private let searchController = UISearchController(searchResultsController: nil)
    private var tableView: UITableView = {
        let tableView = UITableView.newAutolayoutTableView()
        return tableView
    }()

    private let loadingVC = LoadingViewController()

    private var viewModel: RecipesViewModelProtocol? {
        didSet {
            loadViewIfNeeded()

            viewModel?.recipesModel.bindAndFire { [weak self] _ in
                guard let self = self else {
                      return
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }

            viewModel?.cellsViewModel.bindAndFire { [weak self] _ in
                guard let self = self else {
                      return
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }

            viewModel?.displaySpinner = { [weak self]  in
                guard let self = self else {
                      return
                }

                self.displaySpinner()
            }

            viewModel?.hideSpinner = { [weak self]  in
                guard let self = self else {
                      return
                }

                self.hideSpinner()
            }

            viewModel?.presentError = { [weak self] in
                guard let self = self else {
                    return
                }

                self.presentError()
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        constructView()
        constructSubviewHierarchy()
        constructSubviewLayoutConstraints()

        viewModel = RecipesViewModel()
    }

    private func constructView() {
        title = Constants.pageTitle
        view.backgroundColor = .white

        setupTableView()
        setupSearchView()
    }

    private func constructSubviewHierarchy() {
        view.addSubview(tableView)
    }

    private func constructSubviewLayoutConstraints() {
        NSLayoutConstraint.activate([ConstraintUtil.pinTopOfView(tableView, toTopOfView: view,
                                                                         withMargin: 4),
                                     ConstraintUtil.pinLeftOfView(tableView, toLeftOfView: view),
                                     ConstraintUtil.pinRightOfView(tableView, toRightOfView: view),
                                     ConstraintUtil.pinBottomOfView(tableView, toBottomOfView: view)
        ])

    }

    private func setupSearchView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.register(RecipesViewCell.self, forCellReuseIdentifier: Constants.recipesCellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
    }

    // MARK: - Internal Functions

    private func displaySpinner() {
        // Animate loadingVC over the existing views on screen
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve

        present(loadingVC, animated: true, completion: nil)
    }

    private func presentError() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Ooops! Un error ocurrió, intenté nuevamente",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }

    }

    private func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.loadingVC.dismiss(animated: true, completion: nil)
        }

    }

    @IBAction func handleSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel?.displayFavoritiesRecipes(onlyFavorites: false)
        } else {
            viewModel?.displayFavoritiesRecipes(onlyFavorites: true)
        }
    }
}

extension SearchViewcontroller: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searchBar.delegate = self
    }
}

extension SearchViewcontroller: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let recipeTitle = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces) {
            viewModel?.getRecipes(recipleTitle: recipeTitle)
        }
    }
}

extension SearchViewcontroller: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }

        return viewModel.cellsViewModel.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }

        let cell: RecipesViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.cellsViewModel.value[indexPath.row]
        return cell
    }
}
