//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

final public class AudioCapturerBuilder: AudioCapturer {
    weak public var delegate: AudioCapturerDelegate?
    
    private var isAudioCaptureEnable = false
    private var category: AVAudioSession.Category = .record
    private var mode: AVAudioSession.Mode = .measurement
    private var options: AVAudioSession.CategoryOptions = [.duckOthers]
    private var activeOptions: AVAudioSession.SetActiveOptions = [.notifyOthersOnDeactivation]
    
    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    
    public init() {}
    
    deinit {
        finalizeEngine()
    }
    
    
//  MARK: - SET PROPERTIES
        
    public func setAudioSessionCategory(_ category: AVAudioSession.Category = .record,
                                 mode: AVAudioSession.Mode = .measurement,
                                 options: AVAudioSession.CategoryOptions = [.duckOthers]) {
        self.category = category
        self.mode = mode
        self.options = options
    }
    
    public func setActiveOptions(activeOptions: AVAudioSession.SetActiveOptions = .notifyOthersOnDeactivation) {
        self.activeOptions = activeOptions
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func checkPermission() {
        let permission: AudioCapturerPermission = checkPermission()
        
        switch permission {
            case .ok:
                delegate?.permissionGranted()
            case .requestPermission:
                delegate?.requestPermission()
        }
    }
    
    public func requestPermission()  {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            guard let self else {return}
            if !granted {
                delegate?.permissionGranted()
                return
            }
            
            delegate?.permissionDenied()
        }
    }
    
    public func initiateEngine() {
        let permission: AudioCapturerPermission = checkPermission()
        
        switch permission {
            case .ok:
                installTap()
            case .requestPermission:
                AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
                    guard let self else {return}
                    if granted {
                        installTap()
                        return
                    }
                    delegate?.permissionDenied()
                }
                return
        }
    }
    
    public func finalizeEngine() {
        audioEngine.stop()
        
        audioEngine.inputNode.removeTap(onBus: 0)
        
        do {
            try activeAudioSession(false)
        } catch let error {
            debugPrint("Error disabling audio session: \(error.localizedDescription)")
        }
        
    }
    
    public func startAudioCapture() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now(), execute: { [weak self] in
            guard let self else {return}
            
            isAudioCaptureEnable = true
            
            try? configCategory()
            
            try? activeAudioSession(true)
            
            if !audioEngine.isRunning {
                try? audioEngine.start()
            }
        })
    }
    
    public func stopAudioCapture(_ completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            guard let self else {return}
            
            isAudioCaptureEnable = false
            
            try? activeAudioSession(false)
            
            DispatchQueue.main.async(execute: {
                completion?()
            })
        })
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configCategory() throws {
        try audioSession.setCategory(category, mode: mode, options: options)
    }
    
    private func activeAudioSession(_ activate: Bool) throws {
        try audioSession.setActive(activate, options: activeOptions)
    }
    
    private func installTap() {
        let inputNode = audioEngine.inputNode
        
        let format = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            guard let self else {return}
            
            if !isAudioCaptureEnable { return }
            
            DispatchQueue.main.async(execute: { [weak self] in
                self?.delegate?.outputAudioCapture(buffer: buffer)
            })
        }
        
        audioEngine.prepare()
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
