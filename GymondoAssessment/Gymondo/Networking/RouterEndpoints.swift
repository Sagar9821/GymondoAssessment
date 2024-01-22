//
//  RouterEndpoints.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

public enum Router: APIRouter {
    
    case getExercisebaseinfo(limit: Int,offset: Int)
    case getExerciseInfo(id: Int)
    
    func asURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: Environment.BASEURL) else {  return nil }
        urlComponents.path = "\(urlComponents.path)\(curl)"
        
        if let queryParams = queryParams {
            var params: [URLQueryItem] = []
            for(key,value) in queryParams {
                params.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = params
        }
        guard let finalURL = urlComponents.url else {  return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        return request
    }
}

extension Router {
    public var method: HTTPMethod {
        switch self {
        case .getExercisebaseinfo,.getExerciseInfo:
            return .get
        }
    }
    
    public var curl: String {
        switch self {
        case .getExercisebaseinfo:
            return "/exercisebaseinfo"
        case .getExerciseInfo(id: let id):
            return "/exercisebaseinfo/\(id)"
        }
    }
    
}

extension Router {
    public var queryParams: [String : String]? {
        switch self {
        case .getExercisebaseinfo(let limit, let offset):
            return ["limit":"\(limit)","offset":"\(offset)"]
        case .getExerciseInfo:
            return nil
        }
    }
}
