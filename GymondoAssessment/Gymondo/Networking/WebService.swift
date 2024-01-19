//
//  WebService.swift
//  Gymondo
//
//  Created by psagc on 19/01/24.
//

import Foundation
import Combine

protocol WebServiceType {
    func fetch<T: Codable>(router: Router) -> AnyPublisher<T, WebServiceRequestError>
}
