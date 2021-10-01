//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

class ClassifiedDetailsViewModel {
    private(set) var model: Classified!
    var numberOfImages: Int {
        model.imageUrls.count
    }

    init(model: Classified) {
        self.model = model
    }
}
