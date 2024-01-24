//
//  MockExerciseService.swift
//  GymondoAssessmentTests
//
//  Created by psagc on 23/01/24.
//

import Foundation
import Gymondo
import Combine

class MockExerciseService: ExerciseServiceType {
        
    var mockedResponse: AnyPublisher<ExercisesResponse, WebServiceRequestError>?
    func fetchExercise(limit: Int, offset: Int) -> AnyPublisher<ExercisesResponse, WebServiceRequestError> {
        if let mockedResponse = mockedResponse {
            return mockedResponse
                .mapError { $0 as WebServiceRequestError }
                .map { $0 }
                .eraseToAnyPublisher()
        } else {
            fatalError("Mocked response is not properly configured.")
        }
    }
    
    var mockedResponseExerciseDetails: AnyPublisher<ExercisesDetails, WebServiceRequestError>?
    
    func fetchExerciseDetails(exerciseId: Int) -> AnyPublisher<ExercisesDetails, WebServiceRequestError> {
        if let mockedResponse = mockedResponseExerciseDetails {
            return mockedResponse
                .mapError { $0 as WebServiceRequestError }
                .map { $0 }
                .eraseToAnyPublisher()
        } else {
            fatalError("Mocked response is not properly configured.")
        }
    }
}
