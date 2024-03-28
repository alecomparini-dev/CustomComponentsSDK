//  Created by Alessandro Comparini on 09/08/23.
//

import UIKit
import SwiftUI


//  MARK: - PREVIEW UIVIEWCONTROLLER SWIFTUI

public extension UIViewController {
    
    private struct SwiftUIViewControllerWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController { viewController }
        
        func updateUIViewController( _ uiViewController: UIViewController, context: Context) {}
    }
    
    var asSwiftUIViewController: some View {
        SwiftUIViewControllerWrapper(viewController: self)
    }
    
}


//  MARK: - HIDE KEYBOARD
public extension UIViewController {
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}
