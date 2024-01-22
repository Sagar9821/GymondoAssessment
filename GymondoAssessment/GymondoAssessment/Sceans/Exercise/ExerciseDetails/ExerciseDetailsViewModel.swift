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
    var exercises: Exercise { get }
    func getExerciseVariations()
    var variations: [Exercise] { get }
}

class ExerciseDetailsViewModel: ObservableObject, ExerciseDetailsViewModelType {
    
    @Published var exercises: Exercise
    @Published var variations: [Exercise] = []
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let exerciseService: ExerciseService
    init(exercises: Exercise,exerciseService: ExerciseService) {
        self.exercises = exercises
        self.exerciseService = exerciseService
    }
    
    func getExerciseVariations() {
        exercises.variations?.forEach({ exerciseId in
            exerciseService.fetchExerciseDetails(exerciseId: exerciseId).sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let _):
                    break
                }
            } receiveValue: { exercise in
                self.variations.append(exercise)
            }.store(in: &cancellable)
        })
    }
    
}
