//
//  ExerciseListViewControllerTests.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//


import XCTest
import Gymondo
import GymondoAssessment

final class ExerciseListViewControllerTests: XCTestCase {

    
    func test_navigation_title() {
        let (vc,_) = getExcrciseListViewController()
        vc.loadViewIfNeeded()
        XCTAssertTrue(vc.viewTitle == "Exercises")
    }

    func test_fetchApiCall_count() {
        let (vc, viewModel) = getExcrciseListViewController()
        vc.loadViewIfNeeded()
        XCTAssert(viewModel.apiCallCountForFetchExercise == 1)
    }
    
    func test_excrcise_rendersSuccessfullyLoadedExercises() {
        let (vc, viewModel) = getExcrciseListViewController()
        vc.loadViewIfNeeded()
        let exercise = ExercisesDetails(id:1, uuid:"151434a5-c046-459f-a3a9-c3125075856f", images:[], exercises:[Exercise(id: 1,
                                                                                                                          uuid: "4371e111-5b1f-4679-968e-bb5d9a48ebe2",
                                                                                                                          name: "Alzate Laterali",
                                                                                                                          exerciseBase: 3,
                                                                                                                          description: "Alzate LateraliAlzate Laterali",
                                                                                                                          language: .english,
                                                                                                                          created: "2023-08-06T10:17:17.349574+02:00")], variations:48)
        viewModel.completeLoadingExercise(exercise: [exercise], for: .english)
        XCTAssert(vc.numberRenderedExerciseView == 1)
        let exercieCell = vc.getExerciseRowView(at: 0)
        XCTAssertNotNil(exercieCell, "exercise not loaded")
        let firstExercise = exercise.exercises?.first(where: {$0.language == .english})
        XCTAssertTrue(exercieCell?.exerciseName == firstExercise?.name)
    }
    
    func getExcrciseListViewController(file: StaticString = #file, line: UInt = #line) -> (ExerciseListViewController,MockExerciseListViewModel) {
        let mockViewModel = MockExerciseListViewModel()
        let excrciseListViewController = GymondoStoryboard.exercise.instantiateViewController(identifier: ExerciseListViewController.storyboardID) { coder in
            return ExerciseListViewController(coder: coder, navigator: MockNavigator(navigationController: UINavigationController()), viewModel: mockViewModel)
        }
        checkMemoryLeaks(excrciseListViewController,file:file,line: line)
        checkMemoryLeaks(mockViewModel,file: file,line: line)
        return (excrciseListViewController,mockViewModel)
    }
    
    func mockCoder() -> NSKeyedUnarchiver {
        let object = UIView()
        let data = try! NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        let coder = try! NSKeyedUnarchiver(forReadingFrom: data)
        return coder
    }
    
}
