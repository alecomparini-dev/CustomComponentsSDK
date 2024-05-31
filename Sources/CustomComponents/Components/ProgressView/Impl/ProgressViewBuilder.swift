//  Created by Alessandro Comparini on 30/04/24.
//

import UIKit

@MainActor
open class ProgressViewBuilder: BaseBuilder, ProgressView {
    public typealias P = UIProgressView
    
    public var get: UIProgressView { progress }
    
//  MARK: - INITIALIZERS
    private let progress: UIProgressView
    
    public init() {
        self.progress = UIProgressView(progressViewStyle: .default)
        super.init(progress)
    }
    
    public init(style: UIProgressView.Style) {
        self.progress = UIProgressView(progressViewStyle: style)
        super.init(progress)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setProgress(_ percent: Float) -> Self {
        progress.setProgress(percent / 100, animated: true)
        return self
    }

    @discardableResult
    public func setTrackColor(_ color: UIColor) -> Self {
        progress.trackTintColor = color
        return self
    }
    
    @discardableResult
    public func setTrackColor(hexColor: String) -> Self {
        guard hexColor.isHexColor() else { return self }
        setTrackColor(UIColor.HEX(hexColor))
        return self
    }
    
    @discardableResult
    public func setProgressColor(_ color: UIColor) -> Self {
        progress.progressTintColor = color
        return self
    }
        
    @discardableResult
    public func setProgressColor(hexColor: String) -> Self {
        guard hexColor.isHexColor() else { return self }
        setProgressColor(UIColor.HEX(hexColor))
        return self
    }
    
    
}
