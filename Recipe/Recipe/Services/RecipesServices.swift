//
//  RecipesServices.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Alamofire
import Foundation

class RecipesServices: BaseService {

    struct Constants {
        static let endPoint = "recipes/random?number=30"
        static let baseURL = "https://api.spoonacular.com/"
        static let searchEndPoint = "recipes/complexSearch?query="
    }

    init() {
        super.init(baseURL: Constants.baseURL)
    }

    func getRamdomRecipes(completionHandler: @escaping(Result<Recipes, Error>) -> Void) {

        getCodable(URL: baseURL + Constants.endPoint,
                   parameters: nil, responseType: Recipes.self) { (response: Recipes?, error: NSError?) in
            if let error = error {
                completionHandler(.failure(error as Error))
            } else if let response = response {
                completionHandler(.success(response))
            } else {
                let erro: Error =  NSError(domain: "", code: 404, userInfo: nil) as Error
                completionHandler(.failure(erro))
            }
        }
    }

    func getRecipes(title: String, completionHandler: @escaping(Result<SearchRecipe, Error>) -> Void) {
        let api = baseURL + Constants.searchEndPoint + title + "&number=30"
        getCodable(URL: api,
                   parameters: nil, responseType: SearchRecipe.self) { (response: SearchRecipe?, error: NSError?) in
            if let error = error {
                completionHandler(.failure(error as Error))
            } else if let response = response {
                completionHandler(.success(response))
            } else {
                let erro: Error =  NSError(domain: "", code: 404, userInfo: nil) as Error
                completionHandler(.failure(erro))
            }
        }
    }
}
