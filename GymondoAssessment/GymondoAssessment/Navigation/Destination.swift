//
//  Destination.swift
//  GymondoAssessment
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Gymondo

public enum Destinations: Equatable {
    public static func == (lhs: Destinations, rhs: Destinations) -> Bool {
        return true
    }
    
    case exerciseDetails(ExercisesDetails)
}
