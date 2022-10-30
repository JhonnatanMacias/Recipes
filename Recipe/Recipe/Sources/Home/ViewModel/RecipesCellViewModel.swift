//
//  RecipesCellViewModel.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 29/10/22.
//

import Foundation

protocol RecipesCellViewModelProtocol: AnyObject {

    var cellModel: Bindable<Recipe> { get }
    var isFavorited: Bindable<Bool> { get }
    var message: Bindable<String> { get }
    var image: Bindable<String> { get }

    var recipeDetailViewModel: Bindable<RecipeDetailViewModel> { get set}
}

class RecipesCellViewModel: RecipesCellViewModelProtocol {

    var cellModel: Bindable<Recipe> = Bindable(Recipe())
    var read: Bindable<Bool> = Bindable(false)
    var isFavorited: Bindable<Bool> = Bindable(false)
    var message: Bindable<String> = Bindable("")
    var image: Bindable<String> = Bindable("")

    var recipeDetailViewModel: Bindable<RecipeDetailViewModel> = Bindable(RecipeDetailViewModel(model: Recipe()))

    init(model: Recipe) {
        cellModel.value = model
        message.value = model.title ?? ""
        image.value = model.image ?? ""
        isFavorited.value = model.isFavorited
        self.recipeDetailViewModel.value = RecipeDetailViewModel(model: model)
    }

}
