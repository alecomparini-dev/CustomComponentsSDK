//  Created by Alessandro Comparini on 01/05/25.
//

public protocol TranscriptFilter {
    func apply(to raw: String) -> String
}
