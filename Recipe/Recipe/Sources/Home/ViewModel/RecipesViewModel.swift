//
//  RecipesViewModel.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Foundation

protocol RecipesViewModelProtocol: AnyObject {

    // MARK: - Properties

    var recipesModel: Bindable<[Recipes]> { get }
    var recipesFavoritesModel: Bindable<[Recipes]> { get }

//    var cellsViewModel: Bindable<[PostCellViewModel]> { get set }


    func viewDidLoad()
    func getRamdomRecipes()

    // MARK: - Events

//    var navigateToPostDetails: ((PostDetail) -> ())? { get set }
    var displaySpinner: ( () -> ())? { get set }
    var hideSpinner: (() -> ())? { get set }
}

class RecipesViewModel: RecipesViewModelProtocol {

    var displaySpinner: (() -> ())?
    var hideSpinner: (() -> ())?
    var recipesModel: Bindable<[Recipes]> = Bindable([])
    var recipesFavoritesModel: Bindable<[Recipes]> = Bindable([])
    var repository = RecipesServices()

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

            switch result {
            case .success(let recipes):
//                let postsUpdated = self.markPostReadIfNeeded(posts: posts)
//                self.setupModel(model: postsUpdated)
//                self.castingToRealmObject(model: postsUpdated)
                print(recipes)
            case .failure(let error):
                print(error)
            }

        }
    }


}
