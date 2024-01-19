//
//  WebServiceRequestError.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation

// MARK: - Error Handling
public enum WebServiceRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case notFound
    case error(_ code: Int)
    case serverError
    case decodingError( _ description: String)
    case timeOut
    case unknownError
}
