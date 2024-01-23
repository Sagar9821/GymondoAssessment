//
//  ExerciseDetailsViewTests.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//

import XCTest
import Gymondo
import GymondoAssessment
import Combine

final class ExerciseDetailsViewTests: XCTestCase {

    func test_exercise_titleName() {
        let (view, viewModel, service) = getExerciseDetailsView()
        service.mockedResponseExerciseDetails = Just(exerciseDetails)
            .setFailureType(to: WebServiceRequestError.self)
            .eraseToAnyPublisher()
        viewModel.getExerciseVariations()
        XCTAssert(viewModel.exercises.id == 1)
    }

    func getExerciseDetailsView() -> (ExerciseDetailsView,ExerciseDetailsViewModel,MockExerciseService) {
        let mockNavigator = MockNavigator(navigationController: UINavigationController())        
        let mockExerciseService = MockExerciseService()
        let viewModel = ExerciseDetailsViewModel(exercises: exerciseDetails, exerciseService: mockExerciseService)
        let exerciseDetailsView = ExerciseDetailsView(viewModel: viewModel, navigator: mockNavigator)
        return (exerciseDetailsView,viewModel,mockExerciseService)
    }
    
    var exerciseDetails: ExercisesDetails {
        let exercise = Exercise(id: 1,
                                uuid: "4371e111-5b1f-4679-968e-bb5d9a48ebe2",
                                name: "Alzate Laterali",
                                exerciseBase: 3,
                                description: "desc", language: .english,
                                created: "2023-08-06T10:17:17.349574+02:00")
        
        let exerciseDetails = ExercisesDetails(id:1, uuid:"151434a5-c046-459f-a3a9-c3125075856f", images:[], exercises:[exercise], variations:48)
        return exerciseDetails
    }
    
}
