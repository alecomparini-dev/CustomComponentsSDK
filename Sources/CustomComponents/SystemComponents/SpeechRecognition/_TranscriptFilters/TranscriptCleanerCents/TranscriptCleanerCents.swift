//  Created by Alessandro Comparini on 01/05/25.
//

import Foundation

struct TranscriptCleanerCents: TranscriptFilter {
    func apply(to raw: String) -> String {
        var text = raw

        let pattern = try! NSRegularExpression(pattern: #"(\d+)\s*/\s*100"#)
        text = pattern.stringByReplacingMatches(
            in: text,
            range: NSRange(text.startIndex..., in: text),
            withTemplate: "e $1 centavos"
        )

        return text
    }
}
