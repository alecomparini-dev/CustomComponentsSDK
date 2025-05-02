//  Created by Alessandro Comparini on 01/05/25.
//

import Speech

final public class SpeechRecognitionBuilder: SpeechRecognition {
    public weak var delegate: SpeechRecognitionDelegate?
    
    private var defaultTaskHint: SFSpeechRecognitionTaskHint?
    private var shouldReportPartialResults: Bool = true
    private var transpcriptFilter: [TranscriptFilter]
    private var wordsToClean = [String]()
    
    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    
    public init(transpcriptFilter: [TranscriptFilter]) {
        recognizer = SFSpeechRecognizer(locale: .current)
        request = SFSpeechAudioBufferRecognitionRequest()
        self.transpcriptFilter = transpcriptFilter
        configure()
    }
    
    public convenience init() {
        self.init(transpcriptFilter: [])
    }
    

//  MARK: - SER PROPERTIES
    
    @discardableResult
    public func setSpeechLocale(locale: Locale) -> Self {
        recognizer = SFSpeechRecognizer(locale: locale)
        setDefaultTaskHint(taskHint: defaultTaskHint ?? .dictation)
        return self
    }
    
    @discardableResult
    public func setShouldReportPartialResults(_ flag: Bool) -> Self {
        shouldReportPartialResults = flag
        return self
    }
    
    @discardableResult
    public func setDefaultTaskHint(taskHint: SFSpeechRecognitionTaskHint) -> Self {
        defaultTaskHint = taskHint
        return self
    }

    @discardableResult
    public func setWordsToClean(words: [String]) -> Self {
        wordsToClean = words
        return self
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func checkPermission() {
        let permission: SpeechRecognitionPermission = checkPermission()
        
        switch permission {
            case .ok:
                delegate?.speechPermissionGranted()
            case .requestPermission:
                delegate?.requestSpeechPermission()
            case .notWork:
                delegate?.speechPermissionNotWork()
        }
    }
    
    public func requestPermission()  {
        SFSpeechRecognizer.requestAuthorization { [weak self] authStatus in
            guard let self else {return}
            
            if authStatus == .authorized {
                delegate?.speechPermissionGranted()
                return
            }
            
            delegate?.speechPermissionDenied()
        }
    }
    
    public func startRecognition() {
        let permission: SpeechRecognitionPermission = checkPermission()
        
        if permission == .notWork {
            delegate?.speechPermissionNotWork()
            return
        }
            
        if permission != .ok {
            SFSpeechRecognizer.requestAuthorization { [weak self] authStatus in
                guard let self else {return}
                
                if authStatus == .authorized { return initiateRecognition() }
                
                delegate?.speechPermissionDenied()
            }
        }
        
        initiateRecognition()
    }
    
    private func initiateRecognition() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now(), execute: { [weak self] in
            guard let self else {return}
            
            resetRecognitionTask()
            
            configShouldReportPartialResults()

            configDefaultTaskHint()
            
            configRecognitionTask()
        })
    }
    
    public func stopRecognition() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let self else {return}
            request?.endAudio()
            resetRecognitionTask()
            recognizer = nil
            request = nil
        })
    }
    
    public func appendAudioCapturer(buffer: AVAudioPCMBuffer) {
        request?.append(buffer)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configDefaultSpeech()
        
        configTranscriptionCleanerCents()
    }
    
    private func configDefaultSpeech() {
        setShouldReportPartialResults(false)
        
        setDefaultTaskHint(taskHint: .dictation)
    }
    
    private func configShouldReportPartialResults() {
        request?.shouldReportPartialResults = shouldReportPartialResults
    }
    
    private func configTranscriptionCleanerCents() {
        let transcriptCents = TranscriptCleanerCents()
        transpcriptFilter.append(transcriptCents)
    }
    
    private func configDefaultTaskHint() {
        recognizer?.defaultTaskHint = defaultTaskHint ?? .dictation
    }
    
    private func resetRecognitionTask() {
        recognitionTask?.cancel()
        
        recognitionTask = nil
    }
    

    private func configRecognitionTask() {
        
        guard let request else { return }
                
        recognitionTask = recognizer?.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }
            
            if let result {
                let text = result.bestTranscription.formattedString
                
                let textFiltered = transpcriptFilterApply(text)
                
                DispatchQueue.main.async(execute: { [weak self] in
                    self?.delegate?.output(speechText: textFiltered)
                })
            }
            
            if error != nil || (result?.isFinal ?? false) {
                stopRecognition()
                
            }
        }
    }
    
    private func transpcriptFilterApply(_ text: String) -> String {
        transpcriptFilter.reduce(text) { partialResult, filter in
            filter.apply(to: partialResult)
        }
    }
    
    private func checkPermission() -> SpeechRecognitionPermission {
        let permission = SFSpeechRecognizer.authorizationStatus()
        
        return switch permission {
            case .denied, .notDetermined:
                .requestPermission
            case .authorized:
                .ok
            case .restricted:
                .notWork
            @unknown default:
                .requestPermission
        }
        
        
    }
    
}
