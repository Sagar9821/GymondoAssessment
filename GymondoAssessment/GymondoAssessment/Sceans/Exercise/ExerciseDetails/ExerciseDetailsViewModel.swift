//
//  ExerciseDetailsViewModel.swift
//  GymondoAssessment
//
//  Created by psagc on 21/01/24.
//

import Foundation
import SwiftUI
import Gymondo

protocol ExerciseDetailsViewModelType  {
    var exercises: Exercise { get }
    func getExerciseVariations()
}

class ExerciseDetailsViewModel: ObservableObject, ExerciseDetailsViewModelType {
    
    @Published var exercises: Exercise
    init(exercises: Exercise) {
        self.exercises = exercises
    }
    
    func getExerciseVariations() {
        
    }
    
}
