//
//  WebServiceRequestError.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

// MARK: - Error Handling
public enum WebServiceRequestError: LocalizedError,Equatable {
    public static func == (lhs: WebServiceRequestError, rhs: WebServiceRequestError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound(error: WebResponseError?)
    case error(_ code: Int)
    case serverError
    case decodingError( _ description: String)
    case timeOut
    case unknownError
    
    public var message: String {
        switch self {
        case .invalidRequest,.badRequest,.forbidden,.error,.serverError,.unknownError:
            return "Something went wrong."
        case .unauthorized:
            return "You are not authorized"
        case .notFound(let error):
            if let message = error?.detail {
                return message
            }
            return "Something went wrong. please contect XXXXXXXXX."
        case .decodingError:
            return "Something went wrong. please contect XXXXXXXXX."
        case .timeOut:
            return "Request timeout"
        }
    }
}

public struct WebResponseError : Codable{
    var detail: String
}
