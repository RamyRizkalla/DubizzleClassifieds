// Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

enum Result {
    case success(Decodable)
    case failure(Error)
}
