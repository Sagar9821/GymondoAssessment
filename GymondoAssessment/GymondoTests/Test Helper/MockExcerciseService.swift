//
//  MockExcerciseService.swift
//  GymondoTests
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine
import Gymondo

class MockExerciseService: ExerciseServiceType {
    
    
    var mockedResponse: AnyPublisher<ExercisesResponse, WebServiceRequestError>?

    func fetchExercise() -> AnyPublisher<ExercisesResponse, WebServiceRequestError> {
        if let mockedResponse = mockedResponse {
            return mockedResponse
                .mapError { $0 as WebServiceRequestError }
                .map { $0 }
                .eraseToAnyPublisher()
        } else {
            fatalError("Mocked response is not properly configured.")
        }
    }
}
