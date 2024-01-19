//
//  RouterEndpoints.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

public enum Router: APIRouter {
    
    case getExercises
    
    func asURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: Environment.BASEURL) else {  return nil }
        urlComponents.path = self.curl
        guard let finalURL = urlComponents.url else {  return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        return request
    }
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
            return "/exerciseinfo"
        }
    }
    
}
