//
//  RecipesViewCell.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 29/10/22.
//

import Foundation
import SDWebImage
import UIKit

class RecipesViewCell: UITableViewCell {

    private enum Constants {
        static let titleTopMargin: CGFloat = 10
        static let titleLeftMargin: CGFloat = 40
        static let titleRightMargin: CGFloat = 50
        static let readIconHeight: CGFloat = 14
        static let readIconLeftMargin: CGFloat = 12
        static let starIconSize: CGFloat = 22
        static let starIconLeftMargin: CGFloat = 10
    }

    // MARK: - Properties

    private var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private var recipeImage: UIImageView = {
        let image = UIImageView.newAutolayoutImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8.0
        image.clipsToBounds = true
        return image
    }()

    private let starImageBtn: UIButton = {
        let iconBtn = UIButton()
        iconBtn.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        iconBtn.setImage(UIImage(systemName: "star.fill")?.withTintColor(UIColor.favoriteButtonColor(), renderingMode: .alwaysOriginal), for: .selected)
        iconBtn.translatesAutoresizingMaskIntoConstraints = false
        iconBtn.isHidden = true
        return iconBtn
    }()

    private var titleLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = UIColor.mainGrayDarkFontColor()
        return label
    }()

    private var dividerView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    var viewModel: RecipesCellViewModelProtocol! {
        didSet {
            viewModel.message.bindAndFire { [weak self] message in
                guard let self = self else {
                    return
                }

                self.titleLabel.text = message
            }

            viewModel.image.bindAndFire { [weak self] imageURL in
                guard let self = self else { return }

                self.recipeImage.sd_setImage(with: URL(string: imageURL),
                                             placeholderImage: UIImage(named: "placeholder.png"))
            }

            viewModel.isFavorited.bindAndFire {  [weak self] isFavorited in
                guard let self = self else { return }

                self.starImageBtn.isHidden = !isFavorited
                self.starImageBtn.isSelected = isFavorited

            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    // MARK: - Private function

    private func commonInit() {

        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none

        contentView.addSubview(containerView)
        NSLayoutConstraint.activate(ConstraintUtil.pinAllSides(of: containerView, to: contentView))

        contentView.addSubview(recipeImage)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(recipeImage,
                                                                  toLeftOfView: containerView,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(recipeImage, toTopOfView: containerView,
                                                                 withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.setHeight(60, toView: recipeImage),
                                     ConstraintUtil.setWidth(120, toView: recipeImage),
                                     ConstraintUtil.pinBottomOfView(recipeImage, toBottomOfView: containerView, withMargin: -Constants.titleTopMargin)
                                    ])

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinRightOfView(titleLabel,
                                                                   toRightOfView: containerView,
                                                                   withMargin:
                                                                    -Constants.titleRightMargin),
                                     ConstraintUtil.centerViewVertically(titleLabel,
                                                                         inContainingView: recipeImage),
                                     ConstraintUtil.pinLeftToRightOfView(titleLabel,
                                                                         toRightOfView: recipeImage,
                                                                        withMargin: 4)
                                    ])

        contentView.addSubview(starImageBtn)
        NSLayoutConstraint.activate([ConstraintUtil.centerViewVertically(starImageBtn, inContainingView: containerView),
                                     ConstraintUtil.setHeight(Constants.starIconSize, toView: starImageBtn),
                                     ConstraintUtil.setWidth(starImageBtn, constant: Constants.starIconSize),
                                     ConstraintUtil.pinLeftOfView(starImageBtn, toLeftOfView: containerView, withMargin: Constants.starIconLeftMargin)
        ])
    }

}

