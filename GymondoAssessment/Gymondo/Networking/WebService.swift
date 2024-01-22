//
//  WebService.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine

protocol WebServiceType {
    func fetch<T: Codable>(type: T.Type, router: Router) -> AnyPublisher<T, WebServiceRequestError> 
}


public struct WebService: WebServiceType {

    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// fetch an Router and returns a publisher
    /// - Parameter router: Router
    /// - Returns: A publisher with the provided result data or an error
    func fetch<T: Codable>(type: T.Type, router: Router) -> AnyPublisher<T, WebServiceRequestError> {
        guard let request = router.asURLRequest() else {
            let errorPublisher = Fail<T, WebServiceRequestError>(error: .invalidRequest)
                .eraseToAnyPublisher()
            return errorPublisher
        }
        print("[\(request.httpMethod?.uppercased() ?? "")] '\(request.url!)'")
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ data, response in

                guard let response = response as? HTTPURLResponse else {
                    throw WebServiceRequestError.unknownError
                }
                
                if !(200...299).contains(response.statusCode) {
                    logRequest(response: response, request: request, success: false)
                    throw getHttpError(response.statusCode)
                } else {
                    logRequest(response: response, request: request, success: true)
                }
                
                return data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: type.self, decoder: JSONDecoder())
            .mapError { error in
                return self.handleError(error)
            }
            .eraseToAnyPublisher()
    }
    /// log response url and statusCode in consol
    func logRequest(response: HTTPURLResponse,request: URLRequest,success: Bool) {
        let symbol: String = success ? "✅" : "❌"
        print(" \(symbol) [\(response.statusCode)] '\(request.url!)'")
    }
    
    
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Web Error
    private func getHttpError(_ statusCode: Int) -> WebServiceRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error(statusCode)
        case 500: return .serverError
        case 501...599: return .badRequest
        default: return .unknownError
        }
    }

    private func handleError(_ error: Error) -> WebServiceRequestError {
        switch error {
        case is Swift.DecodingError:
            if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data corrupted. Context: \(context)")
                    case .keyNotFound(let key, let context):
                        print("Key not found: \(key.stringValue). Context: \(context)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch: \(type). Context: \(context)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type \(type). Context: \(context)")
                    @unknown default:
                        print("An unknown decoding error occurred.")
                    }
                } else {
                    print("An unexpected error occurred: \(error)")
                }
            return .decodingError(error.localizedDescription)
        case let error as WebServiceRequestError:
            return error
        default:
            return .unknownError
        }
    }
}


