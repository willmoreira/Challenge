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
        XCTAssertTrue(filterButton.exists, "O botão de filtro deve existir na tela principal.")
        filterButton.tap()

        let filterScreen = app.navigationBars["Filtro"]
        XCTAssertTrue(filterScreen.waitForExistence(timeout: 5), "A tela de filtro deve ser apresentada.")

        let tfFilter = app.textFields["tfFilter"]
        XCTAssertTrue(tfFilter.exists, "O campo de texto para filtro deve existir.")
        tfFilter.tap()
        tfFilter.typeText("More")

        let pickerWheel = app.pickerWheels.element
        XCTAssertTrue(pickerWheel.exists, "O picker de status deve existir.")
        pickerWheel.adjust(toPickerWheelValue: "Alive")

        let coordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.2, dy: 0.2))
        coordinate.tap()

        let applyFilterButton = app.buttons["btnfilter"]
        XCTAssertTrue(applyFilterButton.waitForExistence(timeout: 5), "O botão para aplicar filtro deve existir.")
        applyFilterButton.tap()

        let table = app.tables["tblVwListCharacter"]
        XCTAssertTrue(table.waitForExistence(
            timeout: 5), "A lista de personagens deve estar visível após aplicar o filtro."
        )
    }
}
