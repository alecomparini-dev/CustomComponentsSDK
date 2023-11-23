//  Created by Alessandro Comparini on 09/08/23.
//

import UIKit
import SwiftUI


//  MARK: - PREVIEW UIVIEW ON SWIFTUI

public extension UIView {
    
    func hideKeyboardWhenViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    func replicateFormat( width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat? = nil ) -> UIBezierPath {
        let replicateWidth = width ?? self.frame.width
        let replicateHeight = height ?? self.frame.height
        let replicateCornerRadius = cornerRadius ?? self.layer.cornerRadius
        
        return UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0),
                                                size: CGSize(width: replicateWidth,
                                                             height: replicateHeight)),
                            byRoundingCorners: self.layer.maskedCorners.toRectCorner ,
                            cornerRadii: CGSize(width: replicateCornerRadius, height: replicateCornerRadius))
    }
    
    func setBackgroundColor(_ color: UIColor) -> Self {
        if self.countShadows().shadowLayer > 0 {
            setBackgroundColorLayer(color)
            return self
        }
        self.backgroundColor = color
        return self
    }
    
//  MARK: - SHADOWS
    func removeShadowByID(_ id: String) {
        if let layerToRemove = self.layer.sublayers?.first(where: { $0.name == id }) {
            layerToRemove.removeFromSuperlayer()
        }
    }
    
    func countShadows() -> (shadowLayer: Int, shadowComponent: Bool) {
        let countShadowLayer = self.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0
        let countShadowComponent = self.layer.shadowOpacity > 0
        return (shadowLayer: countShadowLayer, shadowComponent: countShadowComponent)
    }
    
    func hasShadow() -> Bool {
        let hasShadow = countShadows()
        return (hasShadow.shadowLayer > 0 || hasShadow.shadowComponent)
    }
    
    
//  MARK: - GRADIENT
    func removeGradientByID(_ id: String) {
        if let gradientLayer = self.layer.sublayers?.first(where: { $0.name == id }) {
            gradientLayer.removeFromSuperlayer()
        }
    }

    
//  MARK: - NEUMORPHISM
    func removeNeumorphism() {
        self.removeShadowByID(K.Neumorphism.Identifiers.darkShadowID.rawValue)
        self.removeShadowByID(K.Neumorphism.Identifiers.lightShadowID.rawValue)
        self.removeGradientByID(K.Neumorphism.Identifiers.shapeID.rawValue)
    }

    
//  MARK: - RESIZE
    func layersResizeIfNeeded() {
        self.layer.sublayers?.forEach({ layer in
            if layer.shadowOpacity > 0 {
                layer.shadowPath = self.replicateFormat().cgPath
                return
            }
            if layer is CAShapeLayer {
                (layer as! CAShapeLayer).path = self.replicateFormat().cgPath
                return
            }
            if layer is CAGradientLayer {
                guard let layer = layer as? CAGradientLayer else { return }
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                layer.frame = self.bounds
                layer.maskedCorners = self.layer.maskedCorners
                CATransaction.commit()
                return
            }
        })
    }
    
    
//  MARK: - PRIVATE AREA
    private func setBackgroundColorLayer(_ color: UIColor) {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.cornerRadius = self.layer.cornerRadius
        layer.maskedCorners = self.layer.maskedCorners
        layer.fillColor = color.cgColor
        layer.backgroundColor = color.cgColor
        let position = UInt32(countShadows().shadowLayer)
        self.layer.insertSublayer(layer, at: position )
    }
    
//  MARK: - PREVIEW SWIFTUI
    private struct SwiftUIViewWrapper: UIViewRepresentable {
        let view: UIView
        
        func makeUIView(context: Context) -> UIView { view }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
    
    var asSwiftUIView: some View {
        SwiftUIViewWrapper(view: self)
    }

}

