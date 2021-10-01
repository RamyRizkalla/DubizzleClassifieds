//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import XCTest

enum ClassifiedDetailsPage {
    private static let app = XCUIApplication()

    static var collectionView: XCUIElement {
        app.collectionViews.firstMatch
    }

    static var priceLabel: XCUIElement {
        app.staticTexts["priceLabel"]
    }

    static var itemNameLabel: XCUIElement {
        app.staticTexts["itemNameLabel"]
    }

    static var imageIndicatorLabel: XCUIElement {
        app.staticTexts["imageIndicatorLabel"]
    }

    static func cell(at index: Int) -> XCUIElement {
        return collectionView.cells.element(boundBy: index)
    }
}
