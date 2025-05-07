//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

final public class AudioCapturerBuilder: @unchecked Sendable, AudioCapturer  {
    weak public var delegate: AudioCapturerDelegate?
    
    var count = 0
    
    private var isTapInstalled = false
    private var isAudioCaptureEnable = false
    
    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    
    
//  MARK: - INITIALIZERS
    
    private let category: AVAudioSession.Category
    private let mode: AVAudioSession.Mode
    private let options: AVAudioSession.CategoryOptions
    
    public init(category: AVAudioSession.Category = .record,
                mode: AVAudioSession.Mode = .measurement,
                options: AVAudioSession.CategoryOptions = [.duckOthers]) {
        self.category = category
        self.mode = mode
        self.options = options
    }
        
    
//  MARK: - PUBLIC AREA
    
    public func checkPermission() -> AudioCapturerPermission {
        let permission: AudioCapturerPermission = audioCapturerPermission()
        
        if permission != .ok {
            return .requestPermission
        }
        
        return .ok
    }
    
    public func requestPermission() async -> RequestPermissionStatus {
        return await withCheckedContinuation { continuation in
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if !granted { return continuation.resume(returning: .denied)  }
                
                continuation.resume(returning: .granted)
            }
        }
    }
    
    public func initiateEngine() async throws {
        try await configAudioSession()
        
        installTap()
        
        audioEngine.prepare()
    }
    
    public func finalizeEngine() async throws {
        stopEngine()
        
        audioEngine.inputNode.removeTap(onBus: 0)
        
        do {
            try await activeAudioSession(false)
        } catch let error {
            throw AudioCapturerError.audioSessionFinalizeEngineError(error.localizedDescription)
        }
        
        isTapInstalled = false
    }
    
    public func startAudioCapture() async throws {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.audioCapturerStarted()
        })
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>)  in
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
                guard let self else { return continuation.resume(throwing: AudioCapturerError.startAudioCaptureError("Error startAudioCapturer"))}
                
                isAudioCaptureEnable = true
                
                do {
                    try startEngine()
                    
                    continuation.resume()
                } catch let error {
                    return continuation.resume(throwing: AudioCapturerError.audioEngineStartError(error.localizedDescription))
                }
                
            })
        }
    }
    
    public func stopAudioCapture() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.4, execute: { [weak self] in
            self?.pauseEngine()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
                self?.delegate?.audioCapturerStopped()
            })
        })
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configCategory() async throws {
        try audioSession.setCategory(category, mode: mode, options: options)
    }
    
    private func activeAudioSession(_ activate: Bool) async throws {
        try audioSession.setActive(activate, options: .notifyOthersOnDeactivation)
        
    }
        
    private func installTap() {
        if isTapInstalled { return }
        
        let inputNode = audioEngine.inputNode
        
        let format = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            guard let self else {return}
            
            count += 1
            print("ta chamando", count )
            
            outputAudioCapture(buffer)
        }
        
        isTapInstalled = true
    }
    
    private func startEngine() throws {
        if audioEngine.isRunning { return }
        
        do {
            try audioEngine.start()
        } catch let error {
            throw AudioCapturerError.audioEngineStartError(error.localizedDescription)
        }
    }
    
    private func stopEngine() {
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
    
    private func pauseEngine() {
        if audioEngine.isRunning {
            audioEngine.pause()
        }
    }
    
    private func configAudioSession() async throws {
        try await configCategory()
        
        try await activeAudioSession(true)
    }
    
    private func audioCapturerPermission() -> AudioCapturerPermission {
        if #available(iOS 17.0, *) { return checkPermissionTarget17More() }
        
        let permission = AVAudioSession.sharedInstance().recordPermission
        
        return switch permission {
            case .denied, .undetermined:
                .requestPermission
            case .granted:
                .ok
            @unknown default:
                .requestPermission
        }
    }
    
    @available(iOS 17.0, *)
    private func checkPermissionTarget17More() -> AudioCapturerPermission  {
        let permission = AVAudioApplication.shared.recordPermission
        
        return switch permission {
            case .denied, .undetermined:
                .requestPermission
            case .granted:
                .ok
            @unknown default:
                .requestPermission
        }
    }

    private func outputAudioCapture(_ buffer: AVAudioPCMBuffer) {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.outputAudioCapture(buffer: buffer)
        })
    }
    
}
