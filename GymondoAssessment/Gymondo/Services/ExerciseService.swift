//
//  ExerciseService.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine

public protocol ExerciseServiceType {
    func fetchExercise(limit: Int, offset: Int) -> AnyPublisher<ExercisesResponse, WebServiceRequestError>
    func fetchExerciseDetails(exerciseId: Int) -> AnyPublisher<ExercisesDetails,WebServiceRequestError>
}

public struct ExerciseService: ExerciseServiceType {
    private let webService = WebService()
    
    public init() {}
    public func fetchExercise(limit: Int, offset: Int) -> AnyPublisher<ExercisesResponse, WebServiceRequestError> {
        let result = webService.fetch(type: ExercisesResponse.self, router: .getExercisebaseinfo(limit: limit, offset: offset))
        return result.eraseToAnyPublisher()
    }
    
    public func fetchExerciseDetails(exerciseId: Int) -> AnyPublisher<ExercisesDetails,WebServiceRequestError> {
        let result = webService.fetch(type: ExercisesDetails.self, router: .getExerciseInfo(id: exerciseId))
        return result.eraseToAnyPublisher()
    }
}
