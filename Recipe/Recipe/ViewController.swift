//
//  ViewController.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: RecipesViewModelProtocol? {
        didSet {
            loadViewIfNeeded()

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        viewModel = RecipesViewModel()
        viewModel?.viewDidLoad()
    }


}

