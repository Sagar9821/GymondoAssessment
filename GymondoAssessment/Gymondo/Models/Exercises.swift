//
//  Exercises.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

// MARK: - ExercisesResponse
public struct ExercisesResponse: Codable {
    public let results: [Exercise]?
    public init(results: [Exercise]?) {
        self.results = results
    }
}

// MARK: - ExerciseImage
public struct ExerciseImage: Codable, Hashable {
    
    public let id: Int?
    public let uuid: String?
    public let exerciseBase: Int?
    public let exerciseBaseUUID: String?
    public let image: String?
    public let isMain: Bool?

    public init(id: Int?, uuid: String?, exerciseBase: Int?, exerciseBaseUUID: String?, image: String?, isMain: Bool?) {
        self.id = id
        self.uuid = uuid
        self.exerciseBase = exerciseBase
        self.exerciseBaseUUID = exerciseBaseUUID
        self.image = image
        self.isMain = isMain
    }

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case exerciseBase = "exercise_base"
        case exerciseBaseUUID = "exercise_base_uuid"
        case image
        case isMain = "is_main"
    }
}

// MARK: - Exercise
public struct Exercise: Codable, Equatable {
    
    public let id: Int?
    public let uuid, name: String?
    public let exerciseBase: Int?
    public let description: String?
    public let images: [ExerciseImage]?
    public let created: String?
    public let variations: [Int]?

    public init(id: Int?, uuid: String?, name: String?, exerciseBase: Int?, description: String?, images: [ExerciseImage]?, created: String?, variations: [Int]?) {
        self.id = id
        self.uuid = uuid
        self.name = name
        self.exerciseBase = exerciseBase
        self.description = description
        self.images = images
        self.created = created
        self.variations = variations
    }

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case exerciseBase = "exercise_base"
        case description, images, created
        case variations
    }

    public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


