import XCTest

class DetailCharacterViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testDetailCharacterScreen() throws {

        let tableView = app.tables["tblVwListCharacter"]
        let firstCell = tableView.cells.firstMatch

        firstCell.tap()

        let detailViewTitle = app.navigationBars.staticTexts["Detalhes do Personagem"]
        XCTAssertTrue(detailViewTitle.waitForExistence(timeout: 5), "DetailCharacterViewController not presented")

        let backgroundImageView = app.images["imgBackgroundDetail"]
        XCTAssertTrue(backgroundImageView.waitForExistence(timeout: 5), """
        A imagem de fundo deve estar visível na tela de detalhes do personagem.
        """
        )

        let imgCharacter = app.images["imgCharacter"]
        XCTAssertTrue(imgCharacter.waitForExistence(timeout: 5), """
        A imagem de fundo deve estar visível na tela de detalhes do personagem.
        """
        )
    }

}
