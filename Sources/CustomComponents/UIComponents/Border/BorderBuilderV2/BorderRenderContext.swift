//
//  BorderRenderContext.swift
//  CustomComponentsSDK
//
//  Created by Alessandro Comparini on 09/02/26.
//


import UIKit

struct BorderRenderContext {

    weak var view: UIView?

    var cornerRadius: CGFloat = 0
    var borderWidth: CGFloat = 0
    var borderColor: UIColor?
    var maskedCorners: CACornerMask = []

    var hasIndividualCorners: Bool {
        !maskedCorners.isEmpty
    }

    var modernButton: UIButton? {
        guard let btn = view as? UIButton,
              btn.configuration != nil else { return nil }
        return btn
    }
}
