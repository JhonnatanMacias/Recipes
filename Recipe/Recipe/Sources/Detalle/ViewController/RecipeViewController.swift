//
//  RecipeViewController.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 29/10/22.
//

import Atributika
import SDWebImage
import UIKit

class RecipeViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let pageTitle: String = "Recipes"
        static let recipesCellIdentifier: String = RecipesViewCell.reuseIdentifier
    }

    // MARK: - Properties

    var viewModel: RecipeDetailViewModelProtocol! {
        didSet {
            viewModel.title.bindAndFire { [weak self] message in
                guard let self = self else {
                    return
                }

                self.titleLabel.text = message
            }

            viewModel.summary.bindAndFire { [weak self] message in
                guard let self = self else {
                    return
                }

                let htmlFormat = message.html2Attributed
                self.descriptionLabel.attributedText = htmlFormat
                self.descriptionLabel.font = UIFont.systemFont(ofSize: 18)
            }

            viewModel.minutes.bindAndFire { [weak self] message in
                guard let self = self else {
                    return
                }

                self.minutesLabel.text = "Minutos:\n\(message)"
            }

            viewModel.servings.bindAndFire { [weak self] message in
                guard let self = self else {
                    return
                }

                self.servingLabel.text = "Personas:\n\(message)"
            }

            viewModel.image.bindAndFire { [weak self] imageURL in
                guard let self = self else {
                    return
                }

                self.recipeImage.sd_setImage(with: URL(string: imageURL),
                                             placeholderImage: UIImage(named: "placeholder.png"))
            }

            viewModel.isFavorited.bindAndFire { [weak self] isFavorited in
                guard let self = self else {
                    return
                }

                self.favoriteBtn.isSelected = isFavorited
            }
        }
    }

    private var recipeImage: UIImageView = {
        let image = UIImageView.newAutolayoutImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollIndicatorInsets = .zero
        scrollView.contentInset = .zero
        scrollView.keyboardDismissMode = .onDrag
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let favoriteBtn: UIButton = {
        let iconBtn = UIButton()
        iconBtn.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        iconBtn.setImage(UIImage(systemName: "star.fill")?.withTintColor(UIColor.favoriteButtonColor(), renderingMode: .alwaysOriginal), for: .selected)
        iconBtn.translatesAutoresizingMaskIntoConstraints = false
        return iconBtn
    }()

    private var titleLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor.mainGrayDarkFontColor()
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.mainGrayDarkFontColor()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private var servingLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor.mainGrayDarkFontColor()
        return label
    }()

    private var minutesLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor.mainGrayDarkFontColor()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        constructView()
        constructSubviewHierarchy()
        constructSubviewLayoutConstraints()

//        viewModel = RecipesViewModel()
//        viewModel?.viewDidLoad()

    }

    private func constructView() {
        title = Constants.pageTitle
        view.backgroundColor = .white
        setupPageStyle()
    }

    private func constructSubviewHierarchy() {
        view.addSubview(recipeImage)
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(servingLabel)
        scrollView.addSubview(minutesLabel)
        scrollView.addSubview(descriptionLabel)
    }

    private func constructSubviewLayoutConstraints() {
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(recipeImage, toLeftOfView: view),
                                     ConstraintUtil.pinRightOfView(recipeImage, toRightOfView: view),
                                     ConstraintUtil.setHeight(220, toView: recipeImage),
                                     ConstraintUtil.pinTopOfView(recipeImage, toTopOfView: view)
        ])

        NSLayoutConstraint.activate([
            ConstraintUtil.pinTopToBottomOfView(scrollView, toBottomOfView: recipeImage),
            ConstraintUtil.pinLeftOfView(scrollView, toLeftOfView: view),
            ConstraintUtil.pinRightOfView(scrollView, toRightOfView: view),
            ConstraintUtil.pinBottomOfView(scrollView, toBottomOfView: view)
        ])

        NSLayoutConstraint.activate([
            ConstraintUtil.pinTopOfView(titleLabel, toTopOfView: scrollView, withMargin: 16),
            ConstraintUtil.pinLeftOfView(titleLabel, toLeftOfView: view, withMargin: 16),
            ConstraintUtil.pinRightOfView(titleLabel, toRightOfView: view, withMargin: -16)
        ])

        NSLayoutConstraint.activate([
            ConstraintUtil.pinTopToBottomOfView(minutesLabel, toBottomOfView: titleLabel, withMargin: 16),
            ConstraintUtil.pinLeftOfView(minutesLabel, toLeftOfView: view, withMargin: 16),
            ConstraintUtil.setWidthOfView(minutesLabel, toWidthOfView: view, multiplier: 0.4)
        ])

        NSLayoutConstraint.activate([
            ConstraintUtil.pinTopToBottomOfView(servingLabel, toBottomOfView: titleLabel, withMargin: 16),
            ConstraintUtil.pinRightOfView(servingLabel, toRightOfView: view, withMargin: -16),
            ConstraintUtil.setWidthOfView(servingLabel, toWidthOfView: view, multiplier: 0.4)
        ])

        NSLayoutConstraint.activate([
            ConstraintUtil.pinTopToBottomOfView(descriptionLabel, toBottomOfView: servingLabel, withMargin: 16),
            ConstraintUtil.pinRightOfView(descriptionLabel, toRightOfView: view, withMargin: -16),
            ConstraintUtil.pinLeftOfView(descriptionLabel, toLeftOfView: view, withMargin: 16),
            ConstraintUtil.pinBottomOfView(descriptionLabel, toBottomOfView: scrollView, withMargin: -20)
        ])

    }

    func transparentNavigationBar() {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.setBackgroundImage(UIImage(),for: UIBarMetrics.default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.isTranslucent = true
            navigationController.view.backgroundColor = UIColor.clear
           navigationController.navigationBar.backgroundColor = UIColor.clear
        }
    }

    private func setupPageStyle() {
        self.title = Constants.pageTitle
        view.backgroundColor = .systemGray6
        edgesForExtendedLayout = []
        transparentNavigationBar()
        addRightBarButtonITem()
    }

    private func addRightBarButtonITem() {
        let rightBarBtn = UIBarButtonItem()
        rightBarBtn.customView = favoriteBtn
        favoriteBtn.addTarget(self, action: #selector(didTapFavoriteBtn), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }

    @objc func didTapFavoriteBtn() {
        favoriteBtn.isSelected = !favoriteBtn.isSelected
        var model = viewModel.model.value
        model.isFavorited = true
        viewModel.model.value = model
        viewModel.model = Bindable(model)

        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"),
                                        object: nil,
                                        userInfo: ["Detail": model])

    }

}

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue,
                                                    .targetTextScaling: 1],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

extension NSMutableAttributedString{
    func getAttributedStringByAppending(attributedString:NSMutableAttributedString) -> NSMutableAttributedString{
        let newAttributedString = NSMutableAttributedString()
        newAttributedString.append(self)
        newAttributedString.append(attributedString)
        return newAttributedString
    }
}
