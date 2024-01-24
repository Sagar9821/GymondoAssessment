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
    
    func test_exercise_table_loaded_successful() {
        
        let table = app.tables["exerciseTableView"]
        XCTAssertTrue(table.waitForExistence(timeout: 3), "The exercise table should be visible")
        XCTAssertTrue(table.staticTexts["Bulgarian split squats left"].exists)
        XCTAssertEqual(table.cells.count, 10, "There should be 10 items on the screen")
                
    }
    
    func test_exercise_table_exerciseImages_loading() {
        
        let table = app.tables["exerciseTableView"].firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 3), "The exercise table should be visible")
        XCTAssertTrue(table.staticTexts["Bulgarian split squats left"].exists)
        XCTAssertEqual(table.cells.count, 10, "There should be 10 items on the screen")
        table.swipeUp()
        sleep(2)
    }
}
