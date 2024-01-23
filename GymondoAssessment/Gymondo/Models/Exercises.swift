//
//  Exercises.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

// MARK: - ExercisesResponse
public struct ExercisesResponse: Codable {
    public let results: [ExercisesDetails]?
    public init(results: [ExercisesDetails]?) {
        self.results = results
    }
}

// MARK: - Exercises Details
public struct ExercisesDetails: Codable {
    public let id: Int?
    public let uuid: String?
    public let images: [ExerciseImage]?
    public let exercises: [Exercise]?
    public let variations: Int?

    public init(id: Int, uuid: String, images: [ExerciseImage], exercises: [Exercise], variations: Int) {
        self.id = id
        self.uuid = uuid
        self.images = images
        self.exercises = exercises
        self.variations = variations
    }
    
    enum CodingKeys: String, CodingKey {
        case id, uuid
        case images
        case isMain = "is_main"
        case exercises
        case variations
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        images = try container.decodeIfPresent([ExerciseImage].self, forKey: .images)
        exercises = try container.decodeIfPresent([Exercise].self, forKey: .exercises)
        variations = try container.decodeIfPresent(Int.self, forKey: .variations)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(images, forKey: .images)
        try container.encode(exercises, forKey: .exercises)
        try container.encode(variations, forKey: .variations)
    }
    
    public var mainImage: ExerciseImage? {
        return images?.first(where: {$0.isMain ?? false})
    }
    
}


// MARK: - ExerciseImage
public struct ExerciseImage: Codable, Hashable,Identifiable {
    
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
public struct Exercise: Codable, Equatable,Identifiable, Hashable{
    
    public let id: Int?
    public let uuid, name: String?
    public let exerciseBase: Int?
    public let description: String?
    public let language: Language?
    public let images: [ExerciseImage]?
    public let created: String?

    public init(id: Int?, uuid: String?, name: String?, exerciseBase: Int?, description: String?,language: Language?, images: [ExerciseImage]?, created: String?) {
        self.id = id
        self.uuid = uuid
        self.name = name
        self.exerciseBase = exerciseBase
        self.description = description
        self.language = language
        self.images = images
        self.created = created
    }

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case exerciseBase = "exercise_base"
        case description, images, created, language
    }

    public static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        exerciseBase = try container.decodeIfPresent(Int.self, forKey: .exerciseBase)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        language = try container.decodeIfPresent(Language.self, forKey: .language)
        images = try container.decodeIfPresent([ExerciseImage].self, forKey: .images)
        created = try container.decodeIfPresent(String.self, forKey: .created)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(name, forKey: .name)
        try container.encode(exerciseBase, forKey: .exerciseBase)
        try container.encode(description, forKey: .description)
        try container.encode(language?.rawValue ?? 0, forKey: .language)
        try container.encode(images, forKey: .images)
        try container.encode(created, forKey: .created)
    }
}


