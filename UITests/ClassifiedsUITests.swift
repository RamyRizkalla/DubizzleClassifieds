//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import XCTest

class ClassifiedsUITests: XCTestCase {
    private var app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments = ["-UITesting"]
        app.launch()
    }

    func testClassifieds() throws {
        let totalImagesCount = 3
        let expectedPriceLabel = "AED 5"
        XCTAssertEqual(ClassifiedsListPage.numberOfCells, totalImagesCount)
        ClassifiedsListPage.pressOnCell(at: 0)
        XCTAssertTrue(ClassifiedDetailsPage.priceLabel.waitForExistence(timeout: 5.0))
        XCTAssertTrue(ClassifiedDetailsPage.itemNameLabel.waitForExistence(timeout: 5.0))
        XCTAssertEqual(ClassifiedDetailsPage.priceLabel.label, expectedPriceLabel)
        ClassifiedDetailsPage.collectionView.swipeLeft()
        XCTAssertEqual(ClassifiedDetailsPage.imageIndicatorLabel.label, "2/\(totalImagesCount)")
    }
}
