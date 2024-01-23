//
//  MockExerciseListViewModel.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//

import Combine
import GymondoAssessment
import Gymondo

class MockExerciseListViewModel: ExerciseListViewModelType {
    
    
    
    var exercisesSubject: PassthroughSubject<[ExercisesDetails], Error> =  PassthroughSubject<[ExercisesDetails], Error>()
    
    @Published var _viewState: ViewState = .none
    var viewState: Published<ViewState>.Publisher { $_viewState }
    
    var _arrayExercise: [ExercisesDetails] = []
    var arrayExercise: [ExercisesDetails]  {
        return _arrayExercise
    }
    
    @Published var _refreshing: Bool = false
    var refreshing: Published<Bool>.Publisher { $_refreshing }
    
    var apiCallCountForFetchExercise: Int = 0
    func fetchExercise(refreshing: Bool) {
        apiCallCountForFetchExercise += 1
    }
    
    func completeLoadingExercise(exercise: [ExercisesDetails]) {
        _arrayExercise.append(contentsOf: exercise)
        exercisesSubject.send(exercise)
    }
}
