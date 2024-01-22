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

class ExerciseDetailsViewModel: ObservableObject, ExerciseDetailsViewModelType {
    
    @Published var exercises: ExercisesDetails
    @Published var variations: [Exercise] = []
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let exerciseService: ExerciseService
    init(exercises: ExercisesDetails,exerciseService: ExerciseService) {
        self.exercises = exercises
        self.exerciseService = exerciseService
    }
    
    func getExerciseVariations() {
        if let variations = exercises.variations {
            exerciseService.fetchExerciseDetails(exerciseId: variations).sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let _):
                    break
                }
            } receiveValue: { exercise in
                self.variations.append(exercise)
            }.store(in: &cancellable)
        }
    }
    
}
