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
    
    func changeLanaguage(lanaguage: Exercise.Language) {
        
    }
    
    
    var exercisesSubject: PassthroughSubject<[ExerciseCellViewModel], Error> =  PassthroughSubject<[ExerciseCellViewModel], Error>()
    
    @Published var _viewState: ViewState = .none
    var viewState: Published<ViewState>.Publisher { $_viewState }
    
    var _arrayExercise: [ExerciseCellViewModel] = []
    var arrayExercise: [ExerciseCellViewModel]  {
        return _arrayExercise
    }
    
    @Published var _refreshing: Bool = false
    var refreshing: Published<Bool>.Publisher { $_refreshing }
    
    var apiCallCountForFetchExercise: Int = 0
    func fetchExercise(refreshing: Bool) {
        apiCallCountForFetchExercise += 1
    }
    
    var allExercise: [ExercisesDetails] = []
    func completeLoadingExercise(exercise: [ExercisesDetails],for langauge: Exercise.Language) {
        var filteredExercise: [ExerciseCellViewModel] = [ExerciseCellViewModel]()
        exercise.forEach({ details in
            if let exerice = details.exercises?.first(where: {$0.language == langauge}) {
                allExercise.append(details)
                filteredExercise.append(ExerciseCellViewModel(id: details.id!, exercise: exerice, image: details.mainImage, variations: details.variations, exerciseImages: details.images))
            }
        })
        _arrayExercise.append(contentsOf: filteredExercise)
        exercisesSubject.send(filteredExercise)
    }
    
    func getExerciseDetails(exercise: ExerciseCellViewModel) -> Gymondo.ExercisesDetails? {
        allExercise.first(where: {$0.id == exercise.id ?? 0})
    }
    
}
