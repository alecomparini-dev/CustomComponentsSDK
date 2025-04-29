//  Created by Alessandro Comparini on 28/04/25.
//

import Foundation
import CoreHaptics

open class HapticFeedbackBuilder: HapticFeedback {
    private var eventParameters = Set<CHHapticEventParameter>()
    private var engine: CHHapticEngine?
    
    public init() {
        configure()
    }
    
    public convenience init(mode: HapticMode) {
        self.init()
        self.setHapticMode(mode: mode)
    }
    
    
//  MARK: - SET PROPERTIES
    
    @discardableResult
    public func setHapticMode(mode: HapticMode) -> Self {
        setIntensity(intensity: mode.baseIntensity)
        
        setSharpness(sharpness: mode.baseSharpness)
        
        return self
    }
    
    @discardableResult
    public func setIntensity(intensity value: Float) -> Self {
        let hapticEventParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: value)
        
        eventParameters.insert(hapticEventParam)
        
        return self
    }
    
    @discardableResult
    public func setSharpness(sharpness value: Float) -> Self {
        let hapticEventParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: value)
        
        eventParameters.insert(hapticEventParam)
        
        return self
    }
    
    @discardableResult
    public func setHapticEventParameter(eventParameter: SystemK.Haptic.Event.Parameters, value: Float ) -> Self {
        let hapticEventParam = CHHapticEventParameter(parameterID: SystemKHapticEventParametersMapper.to(eventParameter), value: value)
        
        eventParameters.insert(hapticEventParam)
        
        return self
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func vibrateOnce() {
        startEngine()
        playHaptic()
        stopEngine()
    }
    
    public func vibrateTwice(delayRepeat: Double = 0.15) {
        startEngine()
        
        playHaptic()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayRepeat, execute: { [weak self] in
            self?.playHaptic()
            
            self?.stopEngine()
        })
    }
    
    public func vibrate(times: Int, delayRepeat: Double = 0.15) {
        startEngine()
        
        if times < 1 { return stopEngine() }
        
        let remainingTimes = times - 1
        
        playHaptic()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayRepeat, execute: { [weak self] in
            self?.vibrate(times: remainingTimes, delayRepeat: delayRepeat)
        })
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
        } catch {
            debugPrint("Error initializing the haptics engine: \(error.localizedDescription)")
        }
    }
    
    private func playHaptic() {
        guard let engine = engine else { return }

        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: Array(eventParameters),
            relativeTime: 0
        )

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            
            let player = try engine.makePlayer(with: pattern)
            
            try player.start(atTime: 0)
        } catch {
            print("Erro ao tocar haptic: \(error.localizedDescription)")
        }
    }
    
    private func startEngine() {
        do {
            try engine?.start()
        } catch {
            debugPrint("Error initializing the haptics engine: \(error.localizedDescription)")
            return
        }
    }
    
    private func stopEngine() {
        engine?.stop()
    }

    
}
