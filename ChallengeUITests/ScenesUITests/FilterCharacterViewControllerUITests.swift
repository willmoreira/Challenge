//
//  FilterCharacterViewControllerUITests.swift
//  ChallengeUITests
//
//  Created by William on 17/07/23.
//

import XCTest

class FilterCharacterViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testFilterButtonTapped() {

        let filterButton = app.buttons["btnfilter"]
        XCTAssertTrue(filterButton.exists, "O botão 'Filter' deve existir na tela.")

        filterButton.tap()

        let filterScreen = app.navigationBars["Filtro"]
        XCTAssertTrue(filterScreen.waitForExistence(timeout: 5), """
        A transição para a tela de filtro deve ocorrer em até 5 segundos.
        """
        )

        let tfFilter = app.textFields["tfFilter"]
        tfFilter.tap()
        tfFilter.typeText("Nome do Personagem")

        let pckVwFilter = app.pickers.element
        let pickerWheel = pckVwFilter.pickerWheels.element
        pickerWheel.adjust(toPickerWheelValue: "Dead")

        let coordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.2, dy: 0.2))
        coordinate.tap()

        let btnFilter = app.buttons["btnFilter"]
        XCTAssertTrue(btnFilter.waitForExistence(timeout: 5))
        btnFilter.tap()

        XCTAssertTrue(app.tables["tblVwListCharacter"].exists)
    }
}
