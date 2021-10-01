// Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }
}
