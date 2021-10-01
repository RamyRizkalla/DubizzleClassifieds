//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

extension ProcessInfo {
    var isUITesting: Bool {
        return arguments.contains("-UITesting")
    }
}
