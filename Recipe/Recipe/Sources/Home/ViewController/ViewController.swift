//
//  ViewController.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import UIKit

class ViewController: UIViewController {

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

    @IBOutlet private weak var recipesSegmentControl: UISegmentedControl!

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

            viewModel?.navigateToRecipeDetails = { [weak self] viewModel in
                guard let self = self else {
                      return
                }

                let detailVC = RecipeViewController()
                detailVC.viewModel = viewModel
                self.navigationController?.pushViewController(detailVC,
                                                              animated: true)
            }

            viewModel?.cellsViewModel.bindAndFire { [weak self] _ in
                guard let self = self else {
                      return
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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
        viewModel?.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(favoritePost(aNotification:)), name: NSNotification.Name.init("NotificationIdentifier"), object: nil)
    }

    private func constructView() {
        title = Constants.pageTitle
        view.backgroundColor = .white

        setupTableView()
        setupSearchView()
        setupSegmentedControlStyle()
    }

    private func constructSubviewHierarchy() {
        view.addSubview(tableView)
    }

    private func constructSubviewLayoutConstraints() {
        NSLayoutConstraint.activate([ConstraintUtil.pinTopToBottomOfView(tableView,
                                                                         toBottomOfView: recipesSegmentControl,
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

    @objc private func favoritePost(aNotification: NSNotification) {
        if let userInfo = aNotification.userInfo,
           let recipe = userInfo["Detail"] as? Recipe {
            viewModel?.markPostLikeFavorite(detail: recipe)
            tableView.reloadData()
        }
    }

    private func setupSegmentedControlStyle() {
        if #available(iOS 13.0, *) {
            recipesSegmentControl.selectedSegmentTintColor = UIColor.baseGreenColor()
            recipesSegmentControl.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        } else {
            recipesSegmentControl.tintColor = UIColor.baseGreenColor()
        }

        recipesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        recipesSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        recipesSegmentControl.layer.borderWidth = 1.0
        recipesSegmentControl.layer.borderColor = UIColor.baseGreenColor().cgColor
        recipesSegmentControl.layer.masksToBounds = true
    }

    private func hideNavigationBarBackBtnTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    private func setupTableView() {
        tableView.register(RecipesViewCell.self, forCellReuseIdentifier: Constants.recipesCellIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
    }

    @IBAction func handleSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel?.displayFavoritiesRecipes(onlyFavorites: false)
        } else {
            viewModel?.displayFavoritiesRecipes(onlyFavorites: true)
        }
    }
}

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}

extension ViewController: UITableViewDataSource {

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

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            let detailVM = viewModel.cellsViewModel.value[indexPath.row].recipeDetailViewModel.value
            viewModel.recipeSelected(viewModel: detailVM)
        }
    }
}

