//
//  MockWebService.swift
//  GymondoTests
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine
@testable import Gymondo

class MockWebService: WebServiceType {
   
    
    private(set) var startFetching = false
    private(set) var catchRequests: [URLRequest] = []

    
    var response: AnyPublisher<Data, WebServiceRequestError>?
    func fetch<T:Codable>(type: T.Type, router: Router)  -> AnyPublisher<T, WebServiceRequestError>{
      
        guard let request = router.asURLRequest() else {
            let errorPublisher = Fail<T, WebServiceRequestError>(error: .invalidRequest)
                .eraseToAnyPublisher()
            return errorPublisher
        }
        
        startFetching = true
        catchRequests.append(request)
        if let responseStub = response {
            return responseStub
                .mapError { _ in
                        .invalidRequest
                }
                .flatMap { data in
                    Just(data)
                        .decode(type: type.self, decoder: JSONDecoder())
                        .mapError { error in
                            .decodingError(error.localizedDescription)
                        }
                }
                .eraseToAnyPublisher()
        } else {
            
            let errorPublisher = Fail<T, WebServiceRequestError>(error: .error(501))
                .eraseToAnyPublisher()
            return errorPublisher
        }
    }
    
    
}
