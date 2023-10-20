//  Created by Alessandro Comparini on 20/10/23.
//

import UIKit

public class ShimmerBuilder: BaseBuilder, Shimmer {
    private let shimmer: LoadingShimmer
    
    private weak var component: UIView?
    
    public init(component: UIView) {
        self.shimmer = LoadingShimmer.shared
        self.component = component
        super.init(component)
    }
    

//  MARK: - PUBLIC AREA
    public func startCovering() {
        shimmer.coverSubviews(component, with: nil)
    }
    
    public func stopCovering() {
        shimmer.removeSubviews(component)
    }
    
}




/*
 CREDITS: https://github.com/jogendra/LoadingShimmer/blob/1.0.3/LICENSE
 Copyright (c) 2019 jogendra <imjog24@gmail.com>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  LoadingShimmer.swift
//  LoadingShimmer_Example
//
//  Created by JOGENDRA on 20/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
private let kScreenHeight = UIScreen.main.bounds.size.height
private let safeAreaTopHeight = (kScreenHeight == 812.0 || kScreenHeight == 896.0) ? 88 : 64

public class LoadingShimmer: NSObject {

    public static let shared = LoadingShimmer()

    private override init() {}

    private var _viewCover: UIView?
    private var viewCover: UIView? {
        if _viewCover == nil {
            _viewCover = UIView()
            _viewCover?.tag = 1024
            _viewCover?.backgroundColor = UIColor.clear
        }
        return _viewCover
    }

    private var colorLayer: CAGradientLayer?

    private var maskLayer: CAShapeLayer?

    private var coverablePath: UIBezierPath?
    private var totalCoverablePath: UIBezierPath? {
        if coverablePath == nil {
            coverablePath = UIBezierPath()
        }
        return coverablePath
    }

    private var addOffsetflag = false

    //    Pass the identifiers as nil if the view is not TableView
    fileprivate class func startCovering(_ view: UIView?, with identifiers: [String]?) {
        shared.coverSubviews(view, with: identifiers)
    }

    fileprivate class func stopCovering(_ view: UIView?) {
        shared.removeSubviews(view)
    }


    fileprivate func removeSubviews(_ view: UIView?) {
        view?.viewWithTag(1024)?.removeFromSuperview()
    }

    fileprivate func coverSubviews(_ view: UIView?, with identifiers: [String]?) {

        if view == nil {
            return
        }

        for subview in view?.subviews ?? [] {
            if subview.tag == 1127 {
                return
            }
        }

        if let coverableCellsIds = identifiers {
            if type(of: view!) === UITableView.self {
                for i in 0..<coverableCellsIds.count {
                    getTableViewPath(view, index: i, coverableCellsIds: coverableCellsIds)
                }
                addCover(view)
                return
            }
        }

        viewCover?.backgroundColor = view?.backgroundColor

        if (view?.subviews.count ?? 0) > 0 {
            for subview in view?.subviews ?? [] {

                var defaultCoverblePath = UIBezierPath(roundedRect: subview.bounds, cornerRadius: subview.frame.size.height / 2.0)
                if type(of: subview) === UILabel.self || type(of: subview) === UITextView.self {
                    defaultCoverblePath = UIBezierPath(roundedRect: subview.bounds, cornerRadius: 4)
                }
                let relativePath: UIBezierPath = defaultCoverblePath

                let offsetPoint: CGPoint = subview.convert(subview.bounds, to: view).origin
                subview.layoutIfNeeded()
                relativePath.apply(CGAffineTransform(translationX: offsetPoint.x, y: offsetPoint.y))

                totalCoverablePath?.append(relativePath)
            }
            addCover(view)
        }

    }


    fileprivate func getTableViewPath(_ view: UIView?, index i: Int, coverableCellsIds: [Any]?) {

        let tableView = view as? UITableView


        let cell: UITableViewCell? = tableView?.dequeueReusableCell(withIdentifier: coverableCellsIds?[i] as? String ?? "")
        let headerOffset = getHeaderOffset()

        cell?.frame = CGRect(x: 0, y: (cell?.frame.size.height ?? 0.0) * CGFloat(i) + CGFloat(headerOffset), width: cell?.frame.size.width ?? 0.0, height: cell?.frame.size.height ?? 0.0)

        cell?.layoutIfNeeded()
        for cellSubview in cell?.contentView.subviews ?? [] {
            let defaultCoverblePath = UIBezierPath(roundedRect: cellSubview.bounds, cornerRadius: cellSubview.frame.size.height / 2.0)
            var offsetPoint: CGPoint = cellSubview.convert(cellSubview.bounds, to: tableView).origin
            if i == 0 {
                if offsetPoint.y > cellSubview.frame.origin.y {
                    addOffsetflag = true
                }
            }
            if addOffsetflag {
                offsetPoint.y -= CGFloat(headerOffset)
            }
            cellSubview.layoutIfNeeded()
            defaultCoverblePath.apply(CGAffineTransform(translationX: offsetPoint.x, y: offsetPoint.y + CGFloat(headerOffset)))

            totalCoverablePath?.append(defaultCoverblePath)
        }

    }

    fileprivate func addCover(_ view: UIView?) {
        viewCover?.frame = CGRect(x: 0, y: 0, width: view?.frame.size.width ?? 0.0, height: view?.frame.size.height ?? 0.0)
        view?.addSubview(viewCover!)
        let colorLayer = CAGradientLayer()
        colorLayer.frame = view?.bounds ?? CGRect.zero

        colorLayer.startPoint = CGPoint(x: -1.4, y: 0)
        colorLayer.endPoint = CGPoint(x: 1.4, y: 0)

        colorLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.009).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.02).cgColor
        ]

        colorLayer.locations = [
            NSNumber(value: Double(colorLayer.startPoint.x)),
            NSNumber(value: Double(colorLayer.startPoint.x)),
            NSNumber(value: 0),
            NSNumber(value: 0.2),
            NSNumber(value: 1.2)
        ]

        viewCover?.layer.addSublayer(colorLayer)
        let maskLayer = CAShapeLayer()
        maskLayer.path = totalCoverablePath?.cgPath
        maskLayer.fillColor = UIColor.red.cgColor

        colorLayer.mask = maskLayer

        if let targetBackgroundColor = viewCover?.backgroundColor?.cgColor {
            colorLayer.backgroundColor = targetBackgroundColor
        } else {
            colorLayer.backgroundColor = UIColor.white.cgColor
        }

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = colorLayer.locations
        animation.toValue = [NSNumber(value: 0), NSNumber(value: 1), NSNumber(value: 1), NSNumber(value: 1.2), NSNumber(value: 1.2)]
        animation.duration = 0.9
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        colorLayer.add(animation, forKey: "locations-layer")

    }

    func getHeaderOffset() -> CGFloat {
        if currentViewController() != nil {
            return CGFloat(safeAreaTopHeight)
        } else {
            return 0
        }
    }

    func currentViewController() -> UIViewController? {
        let keyWindow: UIWindow? = CurrentWindow.get
        var vc: UIViewController? = keyWindow?.rootViewController
        while ((vc?.presentedViewController) != nil) {
            vc = vc?.presentedViewController

            if (vc is UINavigationController) {
                vc = (vc as? UINavigationController)?.visibleViewController
            } else if (vc is UITabBarController) {
                vc = (vc as? UITabBarController)?.selectedViewController
            }
        }
        return vc
    }

    func currentNavigationController() -> UINavigationController? {
        return currentViewController()?.navigationController
    }

}
