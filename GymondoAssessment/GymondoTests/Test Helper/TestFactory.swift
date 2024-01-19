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
                         images: [ExerciseImage]? = nil,
                         created: String = "2023-08-06T10:17:17.349574+02:00",
                         variations: [Int] = [1, 2, 3]) -> Exercise {
        return Exercise(id: id, uuid: uuid, name: name, exerciseBase: exerciseBase, description: description, images: images, created: created, variations: variations)
    }
    
    static func exerciseResponse(exercies: [Exercise]) -> Data?{
        let responseData = ExercisesResponse(results: exercies)
        if let data = try? JSONEncoder().encode(responseData) {
            return data
        }
        return nil
    }
}
