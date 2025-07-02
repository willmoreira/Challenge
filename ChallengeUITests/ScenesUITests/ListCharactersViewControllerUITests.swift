//
//  ListCharactersViewControllerUITests.swift
//  ChallengeUITests
//
//  Created by William on 17/07/23.
//

import XCTest

class ListCharactersViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testShowListCharacterAndNavigateToDetailCharacter() {

        let tableView = app.tables["tblVwListCharacter"]
        XCTAssertTrue(tableView.exists, "Table view not found")

        let firstCell = tableView.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "Table view is empty")

        let firstCharacterName = "Rick Sanchez"
        XCTAssertTrue(firstCell.staticTexts[firstCharacterName].exists, """
        First cell does not contain correct character name
        """
        )

        firstCell.tap()

        let detailViewTitle = app.navigationBars.staticTexts["Detalhes do Personagem"]
        XCTAssertTrue(detailViewTitle.waitForExistence(timeout: 5), "DetailCharacterViewController not presented")
    }

    func testGoToFilterScreen() throws {
        let filterButton = app.buttons["btnfilter"]
        XCTAssertTrue(filterButton.exists, "O botão 'Filter' deve existir na tela.")

        filterButton.tap()

        let filterScreen = app.navigationBars["Filtro"]

        XCTAssertTrue(filterScreen.waitForExistence(timeout: 5), """
         A transição para a tela de filtro deve ocorrer em até 5 segundos.
         """
        )
    }
}
