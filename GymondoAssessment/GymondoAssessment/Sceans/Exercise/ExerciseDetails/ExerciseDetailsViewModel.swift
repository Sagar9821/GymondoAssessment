//
//  ExerciseDetailsViewModel.swift
//  GymondoAssessment
//
//  Created by psagc on 21/01/24.
//

import Combine
import SwiftUI
import Gymondo

public protocol ExerciseDetailsViewModelType  {
    var exercises: ExercisesDetails { get }
    func getExerciseVariations()
    var variations: [Exercise] { get }
}

public enum VariationsDetail {
    case loading
    case variations(ExercisesDetails)
    case error(String)
}

public class ExerciseDetailsViewModel: ObservableObject, ExerciseDetailsViewModelType {
    
    @Published public var exercises: ExercisesDetails
    @Published public var variations: [Exercise] = []
    @Published public var variationsDetail: VariationsDetail = .loading
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let exerciseService: ExerciseServiceType
    public init(exercises: ExercisesDetails,exerciseService: ExerciseServiceType) {
        self.exercises = exercises
        self.exerciseService = exerciseService
    }
    
    @MainActor
    public func getExerciseVariations() {
        
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
