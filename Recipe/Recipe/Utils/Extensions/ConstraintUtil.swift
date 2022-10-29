//
//  ConstraintUtil.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Foundation
import UIKit

@objcMembers open class ConstraintUtil: NSObject {

    open class func pinAllSides(of view: UIView,
                                to otherView: UIView,
                                withMargins margins: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {

        var constraints = [NSLayoutConstraint]()

        constraints.append(pinTopOfView(view, toTopOfView: otherView, withMargin: margins.top))
        constraints.append(pinBottomOfView(view, toBottomOfView: otherView, withMargin: margins.bottom))
        constraints.append(pinLeftOfView(view, toLeftOfView: otherView, withMargin: margins.left))
        constraints.append(pinRightOfView(view, toRightOfView: otherView, withMargin: margins.right))

        return constraints
    }

    open class func pinTopOfView(_ view: UIView, toBottomOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinTopOfView(view, toBottomOfView: otherView, withMargin: 0.0)
    }

    open class func pinTopOfView(
        _ view: UIView,
        toBottomOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .top,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .bottom,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinMinTopOfView(
        _ view: UIView,
        toBottomOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .top,
                                  relatedBy: .greaterThanOrEqual,
                                  toItem: otherView,
                                  attribute: .bottom,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinLeftOfView(_ view: UIView, toLeftOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinLeftOfView(view, toLeftOfView: otherView, withMargin: 0.0)
    }

    open class func pinLeftOfView(
        _ view: UIView,
        toLeftOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .left,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .left,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinRightToLeftOfView(_ view: UIView, toLeftOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinRightToLeftOfView(view, toLeftOfView: otherView, withMargin: 0.0)
    }

    open class func pinRightToLeftOfView(
        _ view: UIView,
        toLeftOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .right,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .left,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinLeftToRightOfView(_ view: UIView, toRightOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinLeftToRightOfView(view, toRightOfView: otherView, withMargin: 0.0)
    }

    open class func pinLeftToRightOfView(
        _ view: UIView,
        toRightOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .left,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .right,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinRightOfView(_ view: UIView, toRightOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinRightOfView(view, toRightOfView: otherView, withMargin: 0.0)
    }

    open class func pinRightOfView(
        _ view: UIView,
        toRightOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .right,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .right,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func centerViewHorizontally(_ view: UIView, inContainingView container: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .centerX,
                                  relatedBy: .equal,
                                  toItem: container,
                                  attribute: .centerX,
                                  multiplier: 1.0,
                                  constant: 0.0)
    }

    open class func centerViewVertically(_ view: UIView, inContainingView container: UIView, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .centerY,
                                  relatedBy: .equal,
                                  toItem: container,
                                  attribute: .centerY,
                                  multiplier: 1.0,
                                  constant: constant)
    }

    open class func pinBottomOfView(_ view: UIView, toBottomOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinBottomOfView(view, toBottomOfView: otherView, withMargin: 0.0)
    }

    open class func pinBottomOfView(_ view: UIView,
                                    toBottomOfView otherView: UIView,
                                    withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .bottom,
                                  multiplier: 1.0,
                                  constant: margin)
    }


    open class func pinBottomToTopOfView(_ view: UIView, toTopOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinBottomToTopOfView(view, toTopOfView: otherView, withMargin: 0.0)
    }

    open class func pinBottomToTopOfView(
        _ view: UIView,
        toTopOfView otherView: UIView,
        withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .top,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinTopToBottomOfView(_ view: UIView, toBottomOfView otherView: UIView) -> NSLayoutConstraint {
          return ConstraintUtil.pinTopToBottomOfView(view, toBottomOfView: otherView, withMargin: 0.0)
    }

    open class func pinTopToBottomOfView(_ view: UIView,
                                         toBottomOfView otherView: UIView,
                                         withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .top,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .bottom,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    open class func pinTopOfView(_ view: UIView, toTopOfView otherView: UIView) -> NSLayoutConstraint {
        return ConstraintUtil.pinTopOfView(view, toTopOfView: otherView, withMargin: 0.0)
    }

 open class func pinTopOfView(_ view: UIView,
                              toTopOfView otherView: UIView,
                              withMargin margin: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .top,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .top,
                                  multiplier: 1.0,
                                  constant: margin)
    }

    @available(*, deprecated, message: "Use setConstantConstraintFor")
    open class func setConstantConstraintForView(
        _ view: UIView,
        attribute: NSLayoutConstraint.Attribute,
        constant: CGFloat) -> NSLayoutConstraint {
        return setConstantConstraintFor(view,
                                        attribute: attribute,
                                        constant: constant)
    }

    open class func setWidthOfView(_ view: UIView,
                                   toWidthOfView otherView: UIView?,
                                   multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        return ConstraintUtil.setWidthOfView(view, toWidthOfView: otherView, withMargin: 0.0, multiplier: multiplier)
    }

    open class func setWidth(_ view: UIView,
                             constant: CGFloat = 0,
                             multiplier: CGFloat = 1,
                             priority: UILayoutPriority? = UILayoutPriority(rawValue: 1000),
                             active: Bool? = true) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(item: view,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: multiplier,
                                            constant: constant)
        constraint.isActive = active!
        constraint.priority = priority!
        return constraint
    }

    open class func setWidthOfView(
        _ view: UIView,
        toWidthOfView otherView: UIView?,
        withMargin margin: CGFloat,
        multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .width,
                                  multiplier: multiplier,
                                  constant: margin)
    }

    open class func setHeight(_ height: CGFloat, toView view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil,
                                  attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                  multiplier: 1.0, constant: height)
    }

    open class func setMaxHeight(_ height: CGFloat, toView view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil,
                                  attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                  multiplier: 1.0, constant: height)
    }

    open class func setMinHeight(_ height: CGFloat, toView view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil,
                                  attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                  multiplier: 1.0, constant: height)
    }

    open class func setWidth(_ width: CGFloat, toView view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil,
                                  attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                  multiplier: 1.0, constant: width)
    }

    open class func setHeightOfView(_ view: UIView,
                                    toHeightOfView otherView: UIView?,
                                    multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        return ConstraintUtil.setHeightOfView(view, toHeightOfView: otherView, withMargin: 0.0, multiplier: multiplier)
    }

    open class func setMaxHeightOfView(_ view: UIView,
                                       height: CGFloat,
                                       priority: UILayoutPriority? = UILayoutPriority(rawValue: 1000)) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil,
                                  attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                  multiplier: 1.0, constant: height)
        constraint.isActive = true
        constraint.priority = priority!

        return constraint
    }

    open class func setHeightOfView(
        _ view: UIView,
        toHeightOfView otherView: UIView?,
        withMargin margin: CGFloat,
        multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .height,
                                  relatedBy: .equal,
                                  toItem: otherView,
                                  attribute: .height,
                                  multiplier: multiplier,
                                  constant: margin)
    }

    open class func autolayoutForView(_ view: UIView,
                                      constraints: [String],
                                      views: [String: UIView],
                                      metrics: [String: Any]?) {

        #if DEBUG
        // For development check to make sure autoresizingMasks are turned off
        for view in views.values {
            assert(!view.translatesAutoresizingMaskIntoConstraints, "Please turn off autoresizingMask")
        }

        #endif

        for constraintsWithVisualFormat in constraints {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraintsWithVisualFormat,
                                                               options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                               metrics: metrics,
                                                               views: views))
        }
    }

    open class func setConstantConstraintFor(
        _ view: UIView,
        attribute: NSLayoutConstraint.Attribute,
        constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)

        view.addConstraint(constraint)
        return constraint
    }
}

