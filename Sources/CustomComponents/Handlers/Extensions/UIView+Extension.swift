//  Created by Alessandro Comparini on 09/08/23.
//

import UIKit
import SwiftUI


//  MARK: - PREVIEW UIVIEW ON SWIFTUI

public extension UIView {
    
    private struct SwiftUIViewWrapper: UIViewRepresentable {
        let view: UIView
        
        func makeUIView(context: Context) -> UIView { view }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
    
    var asSwiftUIView: some View {
        SwiftUIViewWrapper(view: self)
    }
    
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
    
//  MARK: - SHADOWS
    func removeShadowByID(_ id: String) {
        if let layerToRemove = self.layer.sublayers?.first(where: { $0.name == id }) {
            layerToRemove.removeFromSuperlayer()
        }
    }
    
    func countShadows() -> Int {
        return self.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0
    }
    
    func hasShadow() -> Bool { return countShadows() > 0 }
}

