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
        let exercise = ExercisesDetails(id:1, uuid:"151434a5-c046-459f-a3a9-c3125075856f", images:[], exercises:[], variations:48)
        viewModel.completeLoadingExercise(exercise: [exercise])
        XCTAssert(vc.numberRenderedExerciseView == 1)
        let exercieCell = vc.getExerciseRowView(at: 1)
        XCTAssertNil(exercieCell, "exercise not loaded")
        let firstExercise = exercise.exercises?.first(where: {$0.language == .english})
        XCTAssertTrue(exercieCell?.exerciseName == firstExercise?.name)
    }
    
    func getExcrciseListViewController() -> (ExerciseListViewController,MockExerciseListViewModel) {
        let mockViewModel = MockExerciseListViewModel()
        let excrciseListViewController = GymondoStoryboard.exercise.instantiateViewController(identifier: ExerciseListViewController.storyboardID) { coder in
            return ExerciseListViewController(coder: coder, navigator: MockNavigator(navigationController: UINavigationController()), viewModel: mockViewModel)
        }
        return (excrciseListViewController,mockViewModel)
    }
    
    func mockCoder() -> NSKeyedUnarchiver {
        let object = UIView()
        let data = try! NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
        let coder = try! NSKeyedUnarchiver(forReadingFrom: data)
        return coder
    }
    
}
