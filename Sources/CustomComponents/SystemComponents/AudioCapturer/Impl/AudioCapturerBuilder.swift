//  Created by Alessandro Comparini on 30/04/25.
//

import AVFoundation

final class AudioCapturerBuilder: AudioCapturer {
    weak var delegate: AudioCapturerDelegate?
    
    private let audioEngine = AVAudioEngine()
    private let audioSession = AVAudioSession.sharedInstance()
    
    public init() {
        configure()
    }
    
    
//  MARK: - SET PROPERTIES
        
    func setAudioSessionCategory(_ category: AVAudioSession.Category = .record,
                                 mode: AVAudioSession.Mode = .measurement,
                                 options: AVAudioSession.CategoryOptions = [.duckOthers]) throws {
        try audioSession.setCategory(category, mode: mode, options: options)
    }
    
    
    func setAudioSessionActivate(_ activate: Bool,
                                 options: AVAudioSession.SetActiveOptions = .notifyOthersOnDeactivation) throws {
        try audioSession.setActive(activate, options: options)
    }
    
    
//  MARK: - PUBLIC AREA
    
    func startAudioCapture() throws {
        installTap()
        
        audioEngine.prepare()
        
        try audioEngine.start()
    }
    
    func stopAudioCapture() {
        audioEngine.stop()
        
        audioEngine.inputNode.removeTap(onBus: 0)
        
        do {
            try setAudioSessionActivate(false)
        } catch let error {
            debugPrint("Error disabling audio session: \(error.localizedDescription)")
        }
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        defaultConfiguration()
    }
    
    private func defaultConfiguration() {
        do {
            try setAudioSessionCategory()
            
            try setAudioSessionActivate(true)
        } catch let error {
            debugPrint("Error creating defaultConfiguration Audio Session", error.localizedDescription)
        }
    }
    
    private func installTap() {
        let inputNode = audioEngine.inputNode
        
        let format = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            self?.delegate?.outputAudioCapture(buffer: buffer)
        }
    }
}
