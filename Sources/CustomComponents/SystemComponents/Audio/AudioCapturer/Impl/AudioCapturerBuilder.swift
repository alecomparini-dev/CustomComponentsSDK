//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation


final public class AudioCapturerBuilder: @unchecked Sendable, AudioCapturer  {
    weak public var delegate: AudioCapturerDelegate?
    
    private var audioCapturerState: AudioCapturerState = .none
    
    private let queueBackground = DispatchQueue(label: "audio-capturer-background-queue", qos: .background)
    
    private var isTapInstalled = false
    
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
    
    public func initiateEngine() {
        if checkPermission() != .ok {
            delegate?.requestPermission()
            return
        }
        
        queueBackground.async(execute: { [weak self] in
            guard let self else { return }
            
            do {
                try configAudioSession()
            } catch let error {
                debugPrint("error config audio session", error.localizedDescription)
            }
            
            installTap()
            
            audioCapturerState = .initiate
        })
        
    }
    
    public func finalizeEngine() throws {
        audioCapturerState = .finalized
        
        queueBackground.async(execute: { [weak self] in
            guard let self else {return}
            
            stopEngine()
            
            try? activeAudioSession(false)
            
            audioEngine.inputNode.removeTap(onBus: 0)
            
            isTapInstalled = false
        })
    }
    
    public func startAudioCapture() async throws {
        if checkPermission() != .ok { return }
        
        audioCapturerState = .willStartCapture
        
        audioCapturerWillStart()
        
        try? activeAudioSession(true)
        
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>)  in
            queueBackground.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
                Task { [weak self] in
                    guard let self else { return continuation.resume(throwing: AudioCapturerError.startAudioCaptureError("Error startAudioCapturer"))}
                    do {
                        try startEngine()
                        continuation.resume()
                    } catch let error {
                        return continuation.resume(throwing: AudioCapturerError.audioEngineStartError(error.localizedDescription))
                    }
                }
            })
        }
    }
    
    public func stopAudioCapture() {
        audioCapturerState = .stopped
        
        stopEngine()
        
        try? activeAudioSession(false)
        
        audioCapturerDidStop()
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configCategory() throws {
        try audioSession.setCategory(category, mode: mode, options: options)
    }
    
    private func activeAudioSession(_ activate: Bool) throws {
        try audioSession.setActive(activate, options: .notifyOthersOnDeactivation)
    }
        
    private func installTap() {
        if isTapInstalled { return }
        
        let inputNode = audioEngine.inputNode
        
        let format = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            guard let self else { return }
                        
            outputBuffer(buffer)
            
            audioCapturerDidStartCapturing()
        }
        
        audioEngine.prepare()
        
        isTapInstalled = true
    }
    
    private func startEngine() throws {
        do {
            try audioEngine.start()
        } catch let error {
            throw AudioCapturerError.audioEngineStartError(error.localizedDescription)
        }
    }
    
    private func stopEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    private func configAudioSession() throws {
        try configCategory()
        
        try activeAudioSession(true)
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

    
//  MARK: - NOTIFY DELEGATES AREA
    
    private func outputBuffer(_ buffer: AVAudioPCMBuffer) {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.outputBuffer(buffer: buffer)
        })
    }
    
    private func audioCapturerWillStart() {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.audioCapturerWillStart()
        })
    }
    
    private func audioCapturerDidStartCapturing() {
        if audioCapturerState == .capturing { return }
        
        if audioCapturerState == .stopped { return stopEngine() }
        
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.audioCapturerDidStartCapturing()
        })
        
        audioCapturerState = .capturing
    }
    
    private func audioCapturerDidStop() {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.audioCapturerDidStop()
        })
    }
    
}
