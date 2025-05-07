//  Created by Alessandro Comparini on 01/05/25.
//

import Speech

final public class SpeechRecognitionBuilder: SpeechRecognition {
    
    public weak var delegate: SpeechRecognitionDelegate?
    
    private var stopRecognitionAppend = true
    
    private var defaultTaskHint: SFSpeechRecognitionTaskHint?
    private var shouldReportPartialResults: Bool = true
    private var locale = Locale(identifier: "pt-BR")
    private var transpcriptFilter = [TranscriptFilter]()
    
    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    
    public init() {
        configure()
    }
        

//  MARK: - SER PROPERTIES
    
    @discardableResult
    public func setSpeechLocale(locale: Locale) -> Self {
        self.locale = locale
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

    
    
//  MARK: - PUBLIC AREA
    
    public func checkPermission() -> SFSpeechRecognizerAuthorizationStatus {
        return SFSpeechRecognizer.authorizationStatus()
    }
    
    public func requestPermission() async -> SFSpeechRecognizerAuthorizationStatus {
        return await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { authStatus in
                return continuation.resume(returning: authStatus)
            }
        }
    }
    
    public func initiateSpeechRecognition() {
        configRecognizer()
        
        configDefaultTaskHint()
    }
    
    public func startRecognition() {
        stopRecognition()
        
        configRequest()
        
        setRecognitionTask()
        
        stopRecognitionAppend = false
    }
    
    public func stopRecognition() {
        stopRecognitionAppend = true
        resetRecognitionTask()
        request?.endAudio()
        request = nil
    }
    
    public func appendAudioCapturer(buffer: AVAudioPCMBuffer) {
        if stopRecognitionAppend { return }
        
        request?.append(buffer)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configDefaultSpeech()
        
        configTranscriptionCleanerCents()
    }
    
    private func configRequest() {
        request = SFSpeechAudioBufferRecognitionRequest()
        
        request?.shouldReportPartialResults = shouldReportPartialResults
        
        request?.requiresOnDeviceRecognition = true
    }

    
    private func configDefaultSpeech() {
        setShouldReportPartialResults(false)
        
        setDefaultTaskHint(taskHint: .dictation)
    }
    
    private func configRecognizer() {
        recognizer = SFSpeechRecognizer(locale: locale)
        
        recognizer?.supportsOnDeviceRecognition = true
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
    
    private func setRecognitionTask() {
        guard let recognizer, let request else { return }
        
        recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }
            
            var textFiltered = ""
            
            if let result {
                let text = result.bestTranscription.formattedString
                
                textFiltered = transpcriptFilterApply(text)
                
                output(textFiltered)
            }
            
            if (result?.isFinal) ?? false {
                output(textFiltered)
                
                stopRecognition()
            }
            
            if error != nil {
                stopRecognition()
                debugPrint("Error recognition task:", error?.localizedDescription ?? "")
                return
            }
            
        }
    }
    
    private func output(_ text: String) {
        DispatchQueue.main.async(execute: { [weak self] in
            self?.delegate?.output(speechText: text)
        })
    }
    
    private func transpcriptFilterApply(_ text: String) -> String {
        transpcriptFilter.reduce(text) { partialResult, filter in
            filter.apply(to: partialResult)
        }
    }
    
    private func speechCheckPermission() -> SpeechRecognitionPermission {
        let permission = SFSpeechRecognizer.authorizationStatus()
        
        return switch permission {
        case .denied:
                .denied
            case .notDetermined:
                .requestPermission
            case .authorized:
                .authorized
            case .restricted:
                .unavailable
            @unknown default:
                .requestPermission
        }
    }
    
}
