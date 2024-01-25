//
//  ExerciseCellViewModel.swift
//  GymondoAssessment
//
//  Created by psagc on 25/01/24.
//

import Foundation
import Gymondo

public struct ExerciseCellViewModel {
    public let id: Int?
    public let exercise: Exercise
    public let image: ExerciseImage?
    public let variations: Int?
    public let exerciseImages: [ExerciseImage]?
    public init(id: Int?, exercise: Exercise, image: ExerciseImage?, variations: Int?, exerciseImages: [ExerciseImage]?) {
        self.id = id
        self.exercise = exercise
        self.image = image
        self.variations = variations
        self.exerciseImages = exerciseImages
    }
}
