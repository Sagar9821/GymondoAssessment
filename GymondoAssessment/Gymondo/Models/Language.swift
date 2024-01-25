//
//  Language.swift
//  Gymondo
//
//  Created by psagc on 22/01/24.
//

import Foundation

extension Exercise {
    public enum Language : Int, Decodable, CaseIterable {
        case deutsch = 1
        case english = 2
        case bulgarian = 3
        case spanish = 4
        case russian = 5
        case nederlands = 6
        case portugues = 7
        case greek = 8
        case czech = 9
        case sweedish = 10
        case norwegian = 11
        case french = 12
        case italian = 13
        case polish = 14
        case ukrainian = 15
        case turkish = 16
        case arabic = 17
        case azerbaijani = 18
        case esperanto = 19
        case persian = 20
        case hebrew = 21
        case croatian = 22
        case indonesian = 23
        case chinese = 24
    }
    
}
extension Exercise.Language {
    public var displayName: String {
        switch self {
        case .deutsch:
            return "Deutsch"
        case .english:
            return "English"
        case .bulgarian:
            return "Bulgarian"
        case .spanish:
            return "Spanish"
        case .russian:
            return "Russian"
        case .nederlands:
            return "Nederlands"
        case .portugues:
            return "Portugues"
        case .greek:
            return "Greek"
        case .czech:
            return "Czech"
        case .sweedish:
            return "Sweedish"
        case .norwegian:
            return "Norwegian"
        case .french:
            return "French"
        case .italian:
            return "Italian"
        case .polish:
            return "Polish"
        case .ukrainian:
            return "Ukrainian"
        case .turkish:
            return "Turkish"
        case .arabic:
            return "Arabic"
        case .azerbaijani:
            return "Azerbaijani"
        case .esperanto:
            return "Esperanto"
        case .persian:
            return "Persian"
        case .hebrew:
            return "Hebrew"
        case .croatian:
            return "Croatian"
        case .indonesian:
            return "Indonesian"
        case .chinese:
            return "Chinese"
        }
    }
}
