//
//  TestFactory.swift
//  GymondoTests
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Gymondo

struct TestFactory {
    static func exercise(id: Int = 1,
                         uuid: String = "4371e111-5b1f-4679-968e-bb5d9a48ebe2",
                         name: String = "Alzate Laterali",
                         exerciseBase: Int = 3,
                         description: String = "Alzate LateraliAlzate Laterali",
                         language: Exercise.Language = .english,
                         created: String = "2023-08-06T10:17:17.349574+02:00") -> Exercise {
        return Exercise(id: id, uuid: uuid, name: name, exerciseBase: exerciseBase, description: description, language: language, created: created)
    }
    
    static func exerciseResponse(exercies: [ExercisesDetails]?) -> Data?{
        let responseData = ExercisesResponse(results: exercies)
        if let data = try? JSONEncoder().encode(responseData) {
            return data
        }
        return nil
    }
    
    static func getExerciseDetails(id: Int = 1, uuid: String = "151434a5-c046-459f-a3a9-c3125075856f", images: [ExerciseImage] = [], exercises: [Exercise] = [], variations: Int = 48) -> ExercisesDetails {
        return ExercisesDetails(id: id, uuid: uuid, images: images, exercises: exercises, variations: variations)
    }
}
