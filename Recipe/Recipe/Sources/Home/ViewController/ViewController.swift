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

    private var tableView: UITableView = {
        let tableView = UITableView.newAutolayoutTableView()
        return tableView
    }()

    @IBOutlet private weak var recipesSegmentControl: UISegmentedControl!
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transparentNavigationBar()
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
        setupSegmentedControlStyle()
    }

    func transparentNavigationBar() {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.setBackgroundImage(nil,for: UIBarMetrics.default)
            navigationController.navigationBar.shadowImage = nil
            navigationController.navigationBar.isTranslucent = true
            navigationController.view.backgroundColor = UIColor.clear
           navigationController.navigationBar.backgroundColor = UIColor.clear
        }
    }

    // MARK: - Internal Functions

    func displaySpinner() {
        // Animate loadingVC over the existing views on screen
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve

        present(loadingVC, animated: true, completion: nil)
    }

    func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.loadingVC.dismiss(animated: true, completion: nil)
        }

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

    private func setupTableView() {
        tableView.register(RecipesViewCell.self, forCellReuseIdentifier: Constants.recipesCellIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
    }

    @IBAction private func presentSearchView(_ sender: Any) {
        let searchView = SearchViewcontroller()
        self.navigationController?.pushViewController(searchView,
                                                      animated: true)
    }

    @IBAction func handleSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel?.displayFavoritiesRecipes(onlyFavorites: false)
        } else {
            viewModel?.displayFavoritiesRecipes(onlyFavorites: true)
        }
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

