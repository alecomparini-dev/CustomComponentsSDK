//  Created by Alessandro Comparini on 09/02/26.
//

import UIKit


final class ShapeLayerBorderRenderer: BorderRenderer {

    private let layerName = "BorderBuilder.ShapeLayer"

    func render(context: BorderRenderContext) {

        guard let view = context.view else { return }

        removeExisting(from: view)

        let shape = CAShapeLayer()
        shape.name = layerName
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = context.borderColor?.cgColor
        shape.lineWidth = context.borderWidth

        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: convert(context.maskedCorners),
            cornerRadii: CGSize(width: context.cornerRadius,
                                height: context.cornerRadius)
        )

        shape.path = path.cgPath
        shape.frame = view.bounds

        view.layer.addSublayer(shape)
    }

    private func removeExisting(from view: UIView) {
        view.layer.sublayers?
            .filter { $0.name == layerName }
            .forEach { $0.removeFromSuperlayer() }
    }

    private func convert(_ mask: CACornerMask) -> UIRectCorner {

        var corners: UIRectCorner = []

        if mask.contains(.layerMinXMinYCorner) { corners.insert(.topLeft) }
        if mask.contains(.layerMaxXMinYCorner) { corners.insert(.topRight) }
        if mask.contains(.layerMinXMaxYCorner) { corners.insert(.bottomLeft) }
        if mask.contains(.layerMaxXMaxYCorner) { corners.insert(.bottomRight) }

        return corners
    }
}
