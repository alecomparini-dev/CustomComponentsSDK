//  Created by Alessandro Comparini on 12/05/25.
//

import UIKit
import AVFAudio

@MainActor
public class WaveAnimationBuilder: UIView, WaveAnimation {
    private var displayLink: CADisplayLink?
    private var phase: CGFloat = 0.0
    private var amplitude: CGFloat = 5.0
    private var targetAmplitude: CGFloat = 0
    private var isAnimating: Bool = false
    
    private var velocity: VelocityWave = .normal
    private var maxAmplitude: CGFloat = 24
    private var width: CGFloat = 2
    private var color: UIColor = .systemGray6
            

//  MARK: - INITIALIZERS
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setWave(velocity: VelocityWave) -> Self {
        self.velocity = velocity
        return self
    }
    
    @discardableResult
    public func setWave(maxAmplitude: CGFloat) -> Self {
        self.maxAmplitude = maxAmplitude
        return self
    }
    
    @discardableResult
    public func setLine(width: CGFloat) -> Self {
        self.width = width
        return self
    }
    
    @discardableResult
    public func setLine(color: UIColor) -> Self {
        self.color = color
        return self
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func updateAmplitude(_ value: Float) {
        if !isAnimating { return }
        
        targetAmplitude = CGFloat(value) * maxAmplitude
    }
    
    public func updateAmplitude(buffer: AVAudioPCMBuffer) {
        if !isAnimating { return }
        
        guard let channelData = buffer.floatChannelData?[0] else { return }
        
        let channelDataValueArray = Array(UnsafeBufferPointer(start: channelData, count: Int(buffer.frameLength)))
        
        let rms = sqrt(channelDataValueArray.map { $0 * $0 }.reduce(0, +) / Float(buffer.frameLength))
        
        let normalized = min(max(rms * 20, 0.0), 1.0)
        
        DispatchQueue.main.async { [weak self] in
            self?.updateAmplitude(normalized)
        }
    }
    
    public func startAnimation() {
        alphaAnimation(hide: false)
        
        isAnimating = true
        
        phase = 0

        displayLink = CADisplayLink(target: self, selector: #selector(updateWave))

        displayLink?.add(to: .main, forMode: .common)
    }
    
    public func stopAnimation() {
        isAnimating = false
        
        alphaAnimation(hide: true) { [weak self] in
            guard let self else { return }
            
            displayLink?.invalidate()
            
            displayLink = nil
        }
    }
    
    public override func draw(_ rect: CGRect) {
        guard isAnimating,
                let context = UIGraphicsGetCurrentContext() else { return }

        context.clear(rect)
        
        let path = UIBezierPath()
        
        let centerY = bounds.midY
        
        let wavelength: CGFloat = bounds.width / 2.0

        for x in stride(from: 0, through: bounds.width, by: 1) {
            let relativeX = x / wavelength
            let y = centerY + amplitude * sin(relativeX * .pi * 2 + phase)
        
            if x == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        color.setStroke()
        
        path.lineWidth = width
        
        path.stroke()
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        alpha = 0
        backgroundColor = .clear
        isOpaque = false
    }
    
    private func alphaAnimation(hide: Bool, _ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = hide ? 0 : 1
        } completion: { finished in
            if !finished { return }
            completion?()
        }
    }
    
    
//  MARK: - OBJC FUNCTIONS
    
    @objc
    private func updateWave() {
        phase += velocity.rawValue
        
        amplitude += (targetAmplitude - amplitude) * 0.15

        setNeedsDisplay()
    }

}
