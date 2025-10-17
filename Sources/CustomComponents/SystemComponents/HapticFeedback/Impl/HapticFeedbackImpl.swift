//  Created by Alessandro Comparini on 16/10/25.
//

import CoreHaptics
import UIKit

open class HapticFeedback: HapticFeedbackProtocol {
    static public let shared = HapticFeedback()
    
    private var restartEngineOnce: Bool = false
    private var typeHaptic: HapticFeedbackType!
    private var engine: CHHapticEngine?
    
    private init() {
        prepareEngine()
    }
    
    
//  MARK: - PLAY
    
    public func play(_ type: HapticFeedbackType) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        typeHaptic = type
        
        let events: [CHHapticEvent]
        
        switch type {
            case .success:
                events = SuccessHapticEvent().event()
                
            case .error:
                events = ErrorHapticEvent().event()
            
            case .warning:
                events = WarningHapticEvent().event()
                
            case .tap:
                events = TapHapticEvent().event()
        
            case .criticalError:
                events = CriticalErrorHapticEvent().event()
            
            case .impactLight:
                return UIImpactFeedbackGenerator(style: .light).impactOccurred()
                
            case .impactMedium:
                return UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                
            case .impactHeavy:
                return UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        
        }
        
        playHaptic(events)
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func stopEngine() {
        engine?.stop()
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func playHaptic(_ events: [CHHapticEvent]) {
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            
            let player = try engine?.makePlayer(with: pattern)
            
            try player?.start(atTime: CHHapticTimeImmediate)
            
        } catch {
            debugPrint("Haptic playback error: \(error)")
            
            restartEngine()
        }
    }
    
    private func prepareEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            
            try engine?.start()
            
            engine?.resetHandler = { [weak self] in
                try? self?.engine?.start()
            }
        } catch {
            print("Haptics engine error: \(error)")
        }
    }
    
    private func restartEngine() {
        if restartEngineOnce { return }
        
        restartEngineOnce = true
        
        DispatchQueue.main.async { [weak self] in
            do {
                try self?.engine?.start()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
                    guard let self else { return }
                    
                    play(typeHaptic)
                })
            } catch {
                debugPrint("Error restart the haptics engine: \(error)")
            }
        }
        
    }
    
}
