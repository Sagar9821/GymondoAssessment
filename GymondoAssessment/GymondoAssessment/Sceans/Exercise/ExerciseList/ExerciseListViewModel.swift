//
//  ExerciseListViewModel.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine
import Gymondo

protocol ExerciseListViewModelType {
    func fetchExercise()
    var exercisesSubject: PassthroughSubject<[Exercise], Error> { get }
    var viewState: Published<ViewState>.Publisher { get }
    var arrayExercise: [Exercise] { get }
}

class ExerciseListViewModel: ExerciseListViewModelType {
    
    var _arrayExercise: [Exercise] = []
    var arrayExercise: [Exercise]  {
        return _arrayExercise
    }
    
    @Published var _viewState: ViewState = .none
    var viewState: Published<ViewState>.Publisher { $_viewState }
    
    var exercisesSubject: PassthroughSubject<[Exercise], Error> = PassthroughSubject<[Exercise], Error>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    let excerciseServices: ExerciseService
    init(excerciseServices: ExerciseService) {
        self.excerciseServices = excerciseServices
    }
    
    func fetchExercise() {
        _viewState = .loading
        excerciseServices.fetchExercise().sink { [weak self] completion in
            
            switch completion {
            case .finished:
                break
            case let .failure(error):
                self?._viewState = .failure(message: error.localizedDescription)
            }
        } receiveValue: { [weak self] excerciseResponse in
            self?._arrayExercise.append(contentsOf: excerciseResponse.results ?? [])
            self?.exercisesSubject.send(excerciseResponse.results ?? [])
       
            self?._viewState = .none
        }.store(in: &cancellable)

    }
}
