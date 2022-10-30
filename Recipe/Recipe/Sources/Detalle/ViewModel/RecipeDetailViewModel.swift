//
//  RecipeDetailViewModel.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 29/10/22.
//

import Foundation


protocol RecipeDetailViewModelProtocol: AnyObject {

    // MARK: - Properties

    var model: Bindable<Recipe> { get set }
    var title: Bindable<String> { get set }
    var image: Bindable<String> { get set }
    var minutes: Bindable<Int> { get set }
    var servings: Bindable<Int> { get set }
    var summary: Bindable<String> { get set }
    var isFavorited: Bindable<Bool> { get set }

    // MARK: - Events

    var startedRecipeDetail: ((Recipe) -> ())? { get set}
}

class RecipeDetailViewModel: RecipeDetailViewModelProtocol {

    var startedRecipeDetail: ((Recipe) -> ())?

    var model: Bindable<Recipe> = Bindable(Recipe())
    var title: Bindable<String> = Bindable("")
    var image: Bindable<String> = Bindable("")
    var minutes: Bindable<Int> = Bindable(0)
    var summary: Bindable<String> = Bindable("")
    var servings: Bindable<Int> = Bindable(0)
    var isFavorited: Bindable<Bool> = Bindable(false)

    init(model: Recipe) {
        self.model.value = model
        title.value = model.title ?? ""
        summary.value = model.summary ?? ""
        minutes.value = model.cookingMinutes ?? 10
        servings.value = model.servings ?? 2
        image.value = model.image ?? ""
        isFavorited.value = model.isFavorited
    }
}
