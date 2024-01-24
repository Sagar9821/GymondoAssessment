//
//  ExerciseScreenFailureUITest.swift
//  GymondoAssessmentUITests
//
//  Created by psagc on 24/01/24.
//

import XCTest
final class ExerciseScreenFailureUITest: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-exercise-networking-success":"0",
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_exercise_list_fails_to_loads() {
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be an alert on the screen")
        
        XCTAssertTrue(alert.staticTexts["Not found."].exists)
        XCTAssertTrue(alert.buttons["Retry"].exists)
                
    }
}
