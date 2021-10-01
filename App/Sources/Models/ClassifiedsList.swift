//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

// MARK: - ClassifiedsList
struct ClassifiedsList: Codable {
    let results: [Classified]
}

// MARK: - Classified
struct Classified: Codable {
    let createdAt: String
    let price: String
    let name: String
    let uid: String
    let imageIds: [String]
    let imageUrls: [String]
    let imageUrlsThumbnails: [String]
}
