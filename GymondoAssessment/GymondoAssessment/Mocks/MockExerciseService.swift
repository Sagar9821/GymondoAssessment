//
//  ExerciseService.swift
//  GymondoAssessment
//
//  Created by psagc on 24/01/24.
//

import Foundation
import Gymondo
import Combine

class MockExerciseService: ExerciseServiceType {
        
    func fetchExercise(limit: Int, offset: Int) -> AnyPublisher<ExercisesResponse, WebServiceRequestError> {
        
        if var response = try? StaticJSONMapper.decode(file: "ExercisebaseinfoStaticData", type: ExercisesResponse.self) {
            if UITestingHelper.isExerciseNetworkSuccessful {
                return Just( response )
                    .setFailureType(to: WebServiceRequestError.self)
                    .eraseToAnyPublisher()
                    .eraseToAnyPublisher()
            } else if UITestingHelper.isExerciseNetworkSuccessfulWithEmptyData {
                
                return Just( ExercisesResponse(results: []) )
                    .setFailureType(to: WebServiceRequestError.self)
                    .eraseToAnyPublisher()
                    .eraseToAnyPublisher()
            }
            
        }
        
        let errorPublisher = Fail<ExercisesResponse, WebServiceRequestError>(error: .notFound(error: WebResponseError(detail: "Not found.")))
            .eraseToAnyPublisher()
        return errorPublisher
    }
    
    
    
    func fetchExerciseDetails(exerciseId: Int) -> AnyPublisher<ExercisesDetails, WebServiceRequestError> {
        if let response = try? StaticJSONMapper.decode(file: "ExercisebaseinfoDetailsStaticData", type: ExercisesDetails.self),
           UITestingHelper.isExerciseDetailsNetworkingSuccessful{
            return Just( response )
                .setFailureType(to: WebServiceRequestError.self)
                .eraseToAnyPublisher()
                .eraseToAnyPublisher()
        }
        
        let errorPublisher = Fail<ExercisesDetails, WebServiceRequestError>(error: .notFound(error: WebResponseError(detail: "Not found.")))
            .eraseToAnyPublisher()
        return errorPublisher
    }
}
