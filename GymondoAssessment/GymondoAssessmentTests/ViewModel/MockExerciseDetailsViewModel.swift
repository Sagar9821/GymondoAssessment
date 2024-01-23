//
//  MockExerciseDetailsViewModel.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//

import Combine
import Gymondo
import GymondoAssessment

    
class MockExerciseDetailsViewModel: ExerciseDetailsViewModelType {
    
    @Published public var exercises: ExercisesDetails
    @Published public var variations: [Exercise] = []
    @Published public var variationsDetail: VariationsDetail = .loading
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
        
    init(exercises: ExercisesDetails) {
        self.exercises = exercises
        
    }
    
    
    var apiCallCountForVariations: Int = 0
    func getExerciseVariations() {
        apiCallCountForVariations += 1
    }
    
    
    
}

