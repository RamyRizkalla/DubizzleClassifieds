// Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

struct DError: Error {
    var type: ErrorType
    var message: String
}

enum ErrorType {
    case clientSide
    case serverError(StatusCode: Int)
}
