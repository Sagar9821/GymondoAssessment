//
//  ExerciseService.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine

public protocol ExerciseServiceType {
    func fetchExercise() -> AnyPublisher<ExercisesResponse, WebServiceRequestError>
}

public struct ExerciseService: ExerciseServiceType {
    private let webService = WebService()
    
    public init() {}
    public func fetchExercise() -> AnyPublisher<ExercisesResponse, WebServiceRequestError> {
        let result = webService.fetch(type: ExercisesResponse.self, router: .getExercises)
        return result.eraseToAnyPublisher()
    }
}