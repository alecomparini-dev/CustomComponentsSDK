//  Created by Alessandro Comparini on 09/02/26.
//


import ObjectiveC
import UIKit

final class BorderLayoutUpdater {

    static var key: UInt8 = 0

    static func attach(to view: UIView) {

        if objc_getAssociatedObject(view, &key) != nil { return }

        let observer = LayoutObserver(view)
        objc_setAssociatedObject(view,
                                 &key,
                                 observer,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

final class LayoutObserver: NSObject {

    weak var view: UIView?

    init(_ view: UIView) {
        self.view = view
        super.init()
        view.addObserver(self,
                         forKeyPath: "bounds",
                         options: .new,
                         context: nil)
    }

    override func observeValue(forKeyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        guard let view else { return }

        view.layer.sublayers?
            .filter { $0.name == "BorderBuilder.ShapeLayer" }
            .forEach { $0.frame = view.bounds }
    }
}
