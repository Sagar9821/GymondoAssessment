//
//  APIRouter.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

public enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public protocol APIRouter {
    var curl: String { get }
    var method: HTTPMethod { get }    
    var queryParams: [String:String]? { get }
}


