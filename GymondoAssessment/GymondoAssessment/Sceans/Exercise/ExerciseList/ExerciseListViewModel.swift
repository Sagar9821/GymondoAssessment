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
    var exercisesSubject: PassthroughSubject<[ExercisesDetails], Error> { get }
    var viewState: Published<ViewState>.Publisher { get }
    var arrayExercise: [ExercisesDetails] { get }
    var refreshing: Published<Bool>.Publisher { get }
        
}

class ExerciseListViewModel: ExerciseListViewModelType {
   
    
    
    @Published var _refreshing: Bool = false
    var refreshing: Published<Bool>.Publisher { $_refreshing }
    
    
    var _arrayExercise: [ExercisesDetails] = []
    var arrayExercise: [ExercisesDetails]  {
        return _arrayExercise
    }
    
    @Published var _viewState: ViewState = .none
    var viewState: Published<ViewState>.Publisher { $_viewState }
    
    var exercisesSubject: PassthroughSubject<[ExercisesDetails], Error> = PassthroughSubject<[ExercisesDetails], Error>()
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
            self?._arrayExercise.append(contentsOf: excerciseResponse.results ?? [])
            self?.exercisesSubject.send(excerciseResponse.results ?? [])
         }.store(in: &cancellable)

    }
}
