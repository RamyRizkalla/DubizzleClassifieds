//  Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

struct FileReader {
    func readJson(forName name: String, bundle: Bundle = Bundle.main) -> Data? {
        guard let bundlePath = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        return try? String(contentsOfFile: bundlePath).data(using: .utf8)
    }
}
