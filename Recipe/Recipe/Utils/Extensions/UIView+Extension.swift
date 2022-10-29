//
//  UIView+Extension.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Foundation
import UIKit

extension UIView {

    class func newAutolayoutLabel() -> UILabel {
        let label : UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.adjustsFontForContentSizeCategory = true
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }

    class func newAutolayoutStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }

    class func newAutolayoutTableView() -> UITableView {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }

}
