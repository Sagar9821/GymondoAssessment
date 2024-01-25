//
//  ExerciseListViewModel.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine
import Gymondo

public protocol ExerciseListViewModelType {
    func fetchExercise(refreshing: Bool)
    var exercisesSubject: PassthroughSubject<[ExerciseCellViewModel], Error> { get }
    var allExercise: [ExercisesDetails] { get }
    var viewState: Published<ViewState>.Publisher { get }
    var arrayExercise: [ExerciseCellViewModel] { get }
    var refreshing: Published<Bool>.Publisher { get }
    func changeLanaguage(lanaguage: Exercise.Language)
    func getExerciseDetails(exercise: ExerciseCellViewModel) -> ExercisesDetails?
}

class ExerciseListViewModel: ExerciseListViewModelType {
   
    
    
    @Published var _refreshing: Bool = false
    var refreshing: Published<Bool>.Publisher { $_refreshing }
    
    private(set) var allExercise: [ExercisesDetails] = [ExercisesDetails]()
    
    var _arrayExercise: [ExerciseCellViewModel] = []
    var arrayExercise: [ExerciseCellViewModel]  {
        return _arrayExercise
    }
    
    @Published var _viewState: ViewState = .none
    var viewState: Published<ViewState>.Publisher { $_viewState }
    
    var exercisesSubject: PassthroughSubject<[ExerciseCellViewModel], Error> = PassthroughSubject<[ExerciseCellViewModel], Error>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    let excerciseServices: ExerciseServiceType
    init(excerciseServices: ExerciseServiceType) {
        self.excerciseServices = excerciseServices
    }
    
    func fetchExercise(refreshing: Bool = false) {
        if refreshing { self._refreshing = true } else { _viewState = .loading }
        excerciseServices.fetchExercise(limit: 40, offset: 0).sink { [weak self] completion in
            switch completion {
            case .finished:
                self?._refreshing = false
                break
            case let .failure(error):
                self?._refreshing = false
                self?._viewState = .failure(message: error.message)
            }
        } receiveValue: { [weak self] excerciseResponse in
            self?._viewState = .none
            self?._refreshing = false
            var tempArray: [ExercisesDetails] = [ExercisesDetails]()
            var exerices: [ExerciseCellViewModel] = [ExerciseCellViewModel]()
            self?.allExercise.removeAll()
            self?.allExercise.append(contentsOf: excerciseResponse.results ?? [])
            self?._arrayExercise.removeAll()
            excerciseResponse.results?.forEach({ details in
                if let exerice = details.exercises?.first(where: {$0.language == LanguageManager.default.language}) {
                    tempArray.append(details)
                    exerices.append(ExerciseCellViewModel(id: details.id!, exercise: exerice, image: details.mainImage, variations: details.variations, exerciseImages: details.images))
                }
            })
            print(exerices.count)
            self?._arrayExercise.append(contentsOf: exerices)
            self?.exercisesSubject.send(exerices)
         }.store(in: &cancellable)
    }
    
    func changeLanaguage(lanaguage: Exercise.Language) {
        self._arrayExercise.removeAll()
        var exerices: [ExerciseCellViewModel] = [ExerciseCellViewModel]()
        allExercise.forEach({ details in
            if let exerice = details.exercises?.first(where: {$0.language == lanaguage}) {
                allExercise.append(details)
                exerices.append(ExerciseCellViewModel(id: details.id!, exercise: exerice, image: details.mainImage, variations: details.variations, exerciseImages: details.images))
            }
        })
        self._arrayExercise.append(contentsOf: exerices)
        self.exercisesSubject.send(exerices)
    }
    
    func getExerciseDetails(exercise: ExerciseCellViewModel) -> ExercisesDetails? {
        allExercise.first(where: {$0.id == exercise.id})
    }
}
