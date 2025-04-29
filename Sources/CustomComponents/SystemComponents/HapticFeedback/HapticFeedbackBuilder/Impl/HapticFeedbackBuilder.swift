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
        playHaptic()
    }
    
    public func vibrateTwice(delayRepeat: Double = 0.15) {
        playHaptic()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayRepeat, execute: { [weak self] in
            self?.playHaptic()
        })
    }
    
    public func vibrate(times: Int, delayRepeat: Double = 0.15) {
        if times < 1 { return }
        
        let remainingTimes = times - 1
        
        playHaptic()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayRepeat, execute: { [weak self] in
            self?.vibrate(times: remainingTimes, delayRepeat: delayRepeat)
        })
    }
    
    public func stopEngine() {
        engine?.stop()
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            startEngineHandlers()
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
            
            DispatchQueue.main.async {
                try? player.start(atTime: CHHapticTimeImmediate)
            }
        } catch {
            print("Erro ao tocar haptic: \(error.localizedDescription)")
            startEngineHandlers()
        }
    }
    
    private func startEngineHandlers() {
        DispatchQueue.main.async {
            do {
                try self.engine?.start()
                print("Motor háptico reiniciado após parada do sistema.")
            } catch {
                print("Erro ao reiniciar o motor: \(error)")
            }
        }

        engine?.resetHandler = {
            print("Motor háptico resetado. Tentando reiniciar...")
            do {
                try self.engine?.start()
            } catch {
                print("Erro ao reiniciar após reset: \(error)")
            }
        }
    }
}
