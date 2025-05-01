//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

final public class AudioCapturerBuilder: AudioCapturer {
    weak public var delegate: AudioCapturerDelegate?
    
    private var category: AVAudioSession.Category = .record
    private var mode: AVAudioSession.Mode = .measurement
    private var options: AVAudioSession.CategoryOptions = [.duckOthers]
    private var activeOptions: AVAudioSession.SetActiveOptions = [.notifyOthersOnDeactivation]
    
    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    
    public init() {}
    
    
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
    
    public func startAudioCapture() throws {
        try configCategory()
        
        try activeAudioSession(true)
        
        installTap()
        
        audioEngine.prepare()
        
        try audioEngine.start()
    }
    
    public func stopAudioCapture() {
        audioEngine.stop()
        
        audioEngine.inputNode.removeTap(onBus: 0)
        
        do {
            try activeAudioSession(false)
        } catch let error {
            debugPrint("Error disabling audio session: \(error.localizedDescription)")
        }
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
            self?.delegate?.outputAudioCapture(buffer: buffer)
        }
    }
    
    private func checkAndRequestPermission(completion: @escaping (Bool) -> Void) {
        let permission = AVAudioSession.sharedInstance().recordPermission
        
        switch permission {
            case .granted:
                completion(true)
                
            case .denied, .undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    print("Microphone access (< iOS 17): \(granted)")
                    completion(granted)
                }
            @unknown default:
                completion(false)
        }
    }
    
}
