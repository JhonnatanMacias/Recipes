//
//  Recipes.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

// MARK: - Recipes
struct Recipes: Codable {
    var recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    var vegetarian, vegan, glutenFree, dairyFree: Bool?
    var preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int?
    var creditsText, sourceName: String?
    var pricePerServing: Double?
    var id: Int?
    var title: String?
    var readyInMinutes, servings: Int?
    var sourceURL: String?
    var image: String?
    var summary: String?
    var dishTypes, diets, occasions: [String]?
    var instructions: String?
    var isFavorited: Bool = false

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, sourceName, pricePerServing, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, summary, dishTypes, diets, occasions, instructions
    }

    init() {}
}


