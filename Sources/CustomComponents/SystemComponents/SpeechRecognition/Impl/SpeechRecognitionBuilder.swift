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
    private let request: SFSpeechAudioBufferRecognitionRequest
    
    public init(transpcriptFilter: [TranscriptFilter]) {
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: "pt-BR"))
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
    
    public func startRecognition() throws {
        resetRecognitionTask()
        
        configShouldReportPartialResults()

        configDefaultTaskHint()
        
        configRecognitionTask()
    }
    
    public func stopRecognition() {
        resetRecognitionTask()
        request.endAudio()
    }
    
    public func appendAudioCapturer(buffer: AVAudioPCMBuffer) {
        request.append(buffer)
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
        request.shouldReportPartialResults = shouldReportPartialResults
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
        recognitionTask = recognizer?.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }
            
            if let result {
                let text = result.bestTranscription.formattedString
                
                let textFiltered = transpcriptFilterApply(text)
                
                delegate?.output(speechText: textFiltered)
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
    
    private func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            print("Speech auth status: \(authStatus)")
        }
    }
    
}
