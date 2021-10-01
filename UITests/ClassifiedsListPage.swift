//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import XCTest

enum ClassifiedsListPage {
    private static let app = XCUIApplication()

    static var table: XCUIElement {
        app.tables.firstMatch
    }

    static var cells: XCUIElementQuery {
        return table.cells
    }

    static var numberOfCells: Int {
        return table.cells.count
    }

    static func cell(at index: Int) -> XCUIElement {
        return table.cells.element(boundBy: index)
    }

    static func pressOnCell(at index: Int) {
        cell(at: index).tap()
    }
}
