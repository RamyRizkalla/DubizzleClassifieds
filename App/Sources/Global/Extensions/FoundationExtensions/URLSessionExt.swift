// Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

public extension URLSession {
    static var stub: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: configuration)
    }
}
