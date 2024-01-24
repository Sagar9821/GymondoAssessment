//
//  ExerciseDetailsScreenUITests.swift
//  GymondoAssessmentUITests
//
//  Created by psagc on 24/01/24.
//

import XCTest

class ExerciseDetailsScreenUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-exercise-networking-success":"1",
            "-variation-networking-success":"1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_exercise_details_loaded_successful() {
        
        let table = app.tables["exerciseTableView"]
        
        XCTAssertTrue(table.waitForExistence(timeout: 3), "The exercise table should be visible")
        let exercise = table.staticTexts["Bulgarian split squats left"]
        XCTAssertTrue(exercise.exists)
        exercise.tap()
        
        XCTAssertTrue(app.staticTexts["Bulgarian split squats left"].exists)
        XCTAssertTrue(app.staticTexts["Variations"].exists)        
        XCTAssertTrue(app.staticTexts["Barbell Reverse Wrist Curl"].exists)
    }
}
