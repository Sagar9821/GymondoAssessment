//
//  UITestingHelper.swift
//  GymondoAssessment
//
//  Created by psagc on 24/01/24.
//
#if DEBUG

import Foundation

struct UITestingHelper {
    
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var isExerciseNetworkSuccessful: Bool {
        ProcessInfo.processInfo.environment["-exercise-networking-success"] == "1"
    }
    
    static var isExerciseDetailsNetworkingSuccessful: Bool {
        ProcessInfo.processInfo.environment["-variation-networking-success"] == "1"
    }
    
    static var isExerciseNetworkSuccessfulWithEmptyData: Bool {
        ProcessInfo.processInfo.environment["-exercise-networking-success-emptyData"] == "1"
    }
}

#endif
