//
//  ExerciseListSuccessTests.swift
//  GymondoAssessmentUITests
//
//  Created by psagc on 24/01/24.
//

import XCTest

final class ExerciseListSuccessTests: XCTestCase {

    private var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-exercise-networking-success":"1"
        ]
        
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_1exercise_table_loaded_successful() {
        
        let table = app.tables["exerciseTableView"]
        XCTAssertTrue(table.waitForExistence(timeout: 3), "The exercise table should be visible")
        XCTAssertTrue(table.staticTexts["Bulgarian split squats left"].exists)
        XCTAssertEqual(table.cells.count, 10, "There should be 10 items on the screen")
                
    }
    
    func test_2exercise_table_exerciseImages_loading() {
        
        let table = app.tables["exerciseTableView"].firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 3), "The exercise table should be visible")
        XCTAssertTrue(table.staticTexts["Bulgarian split squats left"].exists)
        XCTAssertEqual(table.cells.count, 10, "There should be 10 items on the screen")
        table.swipeUp()
        sleep(2)
    }
    
    
    func test_3exercise_table_empty_message_displayed() {
        
        let navBar = app.navigationBars["Exercises"]
        let languageButton = navBar.buttons["English"]
        XCTAssertTrue(languageButton.exists,"Language change button should be visable")
        languageButton.tap()
        let selectLanguage = app.scrollViews.otherElements.buttons["Bulgarian"]
        XCTAssertTrue(selectLanguage.waitForExistence(timeout: 2), "Bulgarian should be visible")
        selectLanguage.tap()
        let lableEmptyMessage = app.staticTexts["No exercise found."]
        XCTAssertTrue(lableEmptyMessage.waitForExistence(timeout: 2), "Empty message should be visible")
    }
}
