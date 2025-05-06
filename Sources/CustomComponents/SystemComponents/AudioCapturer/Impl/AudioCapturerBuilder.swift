//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

final public class AudioCapturerBuilder: AudioCapturer {
    weak public var delegate: AudioCapturerDelegate?
    
    private let audioQueue = DispatchQueue(label: "audio-capturer-queue")
    private let audioMainQueue = DispatchQueue(label: "audio-capturer-main-queue", qos: .userInteractive)
    
    private var isTapInstalled = false
    private var isAudioCaptureEnable = false
    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    
    
//  MARK: - INITIALIZERS
    
    private let category: AVAudioSession.Category
    private let mode: AVAudioSession.Mode
    private let options: AVAudioSession.CategoryOptions
    
    public init(category: AVAudioSession.Category = .record,
                mode: AVAudioSession.Mode = .default,
                options: AVAudioSession.CategoryOptions = [.duckOthers]) {
        self.category = category
        self.mode = mode
        self.options = options
    }
        
    deinit {
        finalizeEngine()
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func requestPermission() async -> RequestPermissionStatus {
        return await withCheckedContinuation { continuation in
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if !granted { return continuation.resume(returning: .denied)  }
                
                continuation.resume(returning: .granted)
            }
        }
        
    }
    
    public func initiateEngine() {
        audioQueue.async(execute: { [weak self] in
            guard let self else { return }
            
            let permission: AudioCapturerPermission = checkPermission()
            
            switch permission {
                case .ok:
                    installTap()
                    
                case .requestPermission:
                    delegate?.requestPermission()
                    return
            }
        })
    }
    
    public func finalizeEngine() {
        audioQueue.async(execute: { [weak self] in
            guard let self else { return }
            
            stopEngine()
            
            audioEngine.inputNode.removeTap(onBus: 0)
            
            activeAudioSession(false)
            
            isTapInstalled = false
        })
    }
    
    public func startAudioCapture() {
        audioMainQueue.async(execute: { [weak self] in
            guard let self else {return}
            let permission: AudioCapturerPermission = checkPermission()
            
            if permission != .ok {
                delegate?.requestPermission()
                return
            }
                        
            isAudioCaptureEnable = true
            
            delegate?.audioCapturerStarted()
            
            startEngine()
            
            activeAudioSession(true)
        })
    }
    
    public func stopAudioCapture() {
        audioQueue.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let self else {return}
            
            isAudioCaptureEnable = false

            pauseEngine()
            
            activeAudioSession(false)
            
            delegate?.audioCapturerStopped()
        })
        
    }
    
    
//  MARK: - PRIVATE AREA
    
    @discardableResult
    private func configCategory() -> Bool {
        do {
            try audioSession.setCategory(category, mode: mode, options: options)
        } catch let error {
            delegate?.error(type: .audioSessionCategory(error.localizedDescription))
            return false
        }

        return true
    }
    
    @discardableResult
    private func activeAudioSession(_ activate: Bool) -> Bool {
        do {
            try audioSession.setActive(activate, options: .notifyOthersOnDeactivation)
        } catch let error {
            delegate?.error(type: .audioSessionActivate(error.localizedDescription))
            return false
        }
        
        return true
    }
        
    private func installTap() {
        if isTapInstalled { return }
        
        if !configAudioSession() { return }
        
        let inputNode = audioEngine.inputNode
        
        let format = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            guard let self else {return}
            
            if !isAudioCaptureEnable { return }
            
            audioQueue.async(execute: { [weak self] in
                self?.delegate?.outputAudioCapture(buffer: buffer)
            })
        }
        
        isTapInstalled = true
        
        audioEngine.prepare()
    }
    
    private func startEngine() {
        if audioEngine.isRunning { return }
        
        do {
            try audioEngine.start()
        } catch let error {
            audioMainQueue.async(execute: { [weak self] in
                self?.delegate?.error(type: .audioEngineStart(error.localizedDescription))
            })
            return
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
    
    private func configAudioSession() -> Bool {
        if !configCategory() {return false}
        
        do {
            try audioSession.setPreferredSampleRate(44_100)
        } catch let error {
            debugPrint("Error set preferred Sample Rate", error.localizedDescription)
        }
        
        do {
            try audioSession.setPreferredIOBufferDuration(0.005)
        } catch let error as NSError {
            print("Unable to set preferred I/O buffer duration:  \(error.localizedDescription)")
        }
        
        return true
    }
    
    private func checkPermission() -> AudioCapturerPermission {
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
    
}
