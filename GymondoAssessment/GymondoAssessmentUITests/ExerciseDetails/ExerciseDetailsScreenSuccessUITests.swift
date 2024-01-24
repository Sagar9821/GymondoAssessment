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
    
    func test_exerciseList_successful() {
        
        let table = app.tables["exerciseTableView"]
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        
        XCTAssertTrue(table.waitForExistence(timeout: 3), "The exercise table should be visible")
        XCTAssertTrue(table.staticTexts["Bulgarian split squats left"].exists)
        table.staticTexts["Bulgarian split squats left"]
                
    }
}
