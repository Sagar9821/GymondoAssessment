//
//  RouterEndpoint.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

public enum Router: APIRouter {
    case getExercises
}

extension Router {
    public var method: HTTPMethod {
        switch self {
        case .getExercises:
            return .get
        }
    }
    
    public var curl: String {
        switch self {
        case .getExercises:
            return ""
        }
    }
    
}
