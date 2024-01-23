//
//  ExerciseDetailsViewModel.swift
//  GymondoAssessment
//
//  Created by psagc on 21/01/24.
//

import Combine
import SwiftUI
import Gymondo

protocol ExerciseDetailsViewModelType  {
    var exercises: ExercisesDetails { get }
    func getExerciseVariations()
    var variations: [Exercise] { get }
}

enum VariationsDetail {
    case loading
    case variations(ExercisesDetails)
    case error(String)
}

class ExerciseDetailsViewModel: ObservableObject, ExerciseDetailsViewModelType {
    
    @Published var exercises: ExercisesDetails
    @Published var variations: [Exercise] = []
    @Published var variationsDetail: VariationsDetail = .loading
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let exerciseService: ExerciseService
    init(exercises: ExercisesDetails,exerciseService: ExerciseService) {
        self.exercises = exercises
        self.exerciseService = exerciseService
    }
    
    func getExerciseVariations() {
        
        if let variations = exercises.variations {
            variationsDetail = .loading
            exerciseService.fetchExerciseDetails(exerciseId: variations).sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.variationsDetail = .error(error.message)
                }
            } receiveValue: { exercise in
                self.variationsDetail = .variations(exercise)
            }.store(in: &cancellable)
        } else {
            variationsDetail = .error("No variations")
        }
    }
    
}
