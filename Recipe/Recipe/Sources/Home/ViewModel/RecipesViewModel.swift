//
//  RecipesViewModel.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Foundation

protocol RecipesViewModelProtocol: AnyObject {

    // MARK: - Properties

    var recipesModel: Bindable<Recipes> { get }
    var recipesFavoritesModel: Bindable<[Recipe]> { get }
    func recipeSelected(viewModel: RecipeDetailViewModel)
    var cellsViewModel: Bindable<[RecipesCellViewModel]> { get set }
    func displayFavoritiesRecipes(onlyFavorites: Bool)

    func viewDidLoad()
    func getRecipes(recipleTitle: String)

    // MARK: - Events

    var navigateToRecipeDetails: ((RecipeDetailViewModel) -> ())? { get set }
    var displaySpinner: ( () -> ())? { get set }
    var hideSpinner: (() -> ())? { get set }
    var presentError: (() -> ())? { get set }
    func markPostLikeFavorite(detail: Recipe)
}

class RecipesViewModel: RecipesViewModelProtocol {

    var displaySpinner: (() -> ())?
    var hideSpinner: (() -> ())?
    var presentError: (() -> ())?
    var recipesModel: Bindable<Recipes> = Bindable(Recipes(recipes: []))
    var recipesFavoritesModel: Bindable<[Recipe]> = Bindable([])
    var recipesAuxModel: Bindable<Recipes> = Bindable(Recipes(recipes: []))
    var repository = RecipesServices()
    var cellsViewModel: Bindable<[RecipesCellViewModel]> = Bindable([])
    var navigateToRecipeDetails: ((RecipeDetailViewModel) -> ())?

    init() { }

    func viewDidLoad() {
        getRamdomRecipes()
    }

    func getRamdomRecipes() {
        displaySpinner?()
        repository.getRamdomRecipes { [weak self] result in
            guard let self = self else {
                return
            }

            self.hideSpinner?()
            switch result {
            case .success(let recipes):
                self.setupModel(model: recipes)
            case .failure(_):
                self.presentError?()
            }
        }
    }

    func getRecipes(recipleTitle: String) {
        displaySpinner?()
        repository.getRecipes(title: recipleTitle) { [weak self] result in
            guard let self = self else {
                return
            }

            self.hideSpinner?()
            switch result {
            case .success(let recipes):
                self.setupSearchModel(model: recipes)
            case .failure(_):
                self.presentError?()
            }
        }
    }

    private func setupSearchModel(model: SearchRecipe) {
        let recipesModel = model.results.compactMap { Recipe(title: $0.title, image: $0.image) }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            let model = Recipes(recipes: recipesModel)
            self.recipesModel.value = model
            self.cellsViewModel.value = model.recipes.compactMap { RecipesCellViewModel(model: $0) }
        }
    }

    private func setupModel(model: Recipes) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            self.recipesModel.value = model
            self.recipesAuxModel.value = model
            self.cellsViewModel.value = model.recipes.compactMap { RecipesCellViewModel(model: $0) }
        }
    }

    func recipeSelected(viewModel: RecipeDetailViewModel) {
        navigateToRecipeDetails?(viewModel)
    }

    func markPostLikeFavorite(detail: Recipe) {
        if let index = cellsViewModel.value.firstIndex( where: { $0.cellModel.value.title == detail.title }) {
            let oldModel = cellsViewModel.value[index]
            oldModel.isFavorited.value = true
            oldModel.recipeDetailViewModel.value.isFavorited.value = true
            cellsViewModel.value[index] = oldModel

        }

        if let index = recipesModel.value.recipes.firstIndex( where: { $0.title == detail.title }) {
            var detail = recipesModel.value.recipes[index]
            detail.isFavorited = true
            recipesModel.value.recipes[index] = detail
            recipesAuxModel.value.recipes[index] = detail
        }
    }

    func displayFavoritiesRecipes(onlyFavorites: Bool) {
        var recipesAux: [Recipe] = []

        if onlyFavorites {
            recipesAux = recipesModel.value.recipes.filter { recipe in
                recipe.isFavorited
            }
            recipesFavoritesModel.value = recipesAux
        } else {
            recipesAux = recipesAuxModel.value.recipes
        }

        cellsViewModel.value = recipesAux.compactMap { RecipesCellViewModel(model: $0)

        }
    }

}
