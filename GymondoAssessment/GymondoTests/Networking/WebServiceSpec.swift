//
//  WebServiceSpec.swift
//  GymondoTests
//
//  Created by psagc on 19/01/24.
//

import XCTest
import Combine
@testable import Gymondo

final class WebServiceSpec: XCTestCase {


   
    func test_getExercieses() {
        // Given
        let sut = getWebService()
        let request = Router.getExercises.asURLRequest()
        
        // When
        let cancellable = sut.fetch(type: ExercisesResponse.self, router: .getExercises)
            .sink(receiveCompletion: { _ in }, receiveValue: { (_: ExercisesResponse) in })

        // Then
        XCTAssertTrue(sut.startFetching)
        XCTAssertEqual(sut.catchRequests.count, 1)
        XCTAssertEqual(sut.catchRequests[0], request)
        XCTAssertNotNil(cancellable)
    }

    func test_errorAtFronted() {
        // Given
        let sut = getWebService()
        sut.response = Fail<Data, WebServiceRequestError>(error: .invalidRequest)
            .eraseToAnyPublisher()
        let request = Router.getExercises.asURLRequest()
        var receivedError: WebServiceRequestError?

        // When
        _ = sut.fetch(type: ExercisesResponse.self, router: .getExercises)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                }
            }, receiveValue: { (_: ExercisesResponse) in })

        // Then
        XCTAssertTrue(sut.startFetching)
        XCTAssertEqual(sut.catchRequests.count, 1)
        XCTAssertEqual(sut.catchRequests[0], request)
        XCTAssertEqual(receivedError, .invalidRequest)
    }
    
    func test_successWithInvalidData() {
        // Given
        let sut = getWebService()
        let request = Router.getExercises.asURLRequest()
        
        let responseData = "incorrect data".data(using: .utf8)!
        sut.response = Just(responseData)
            .setFailureType(to: WebServiceRequestError.self)
            .eraseToAnyPublisher()

        var receivedError: WebServiceRequestError?

        // When
        _ = sut.fetch(type: ExercisesResponse.self, router: .getExercises)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                }
            }, receiveValue: { (_: ExercisesResponse) in })

        let deccodingErrorMessage = "The data couldn’t be read because it isn’t in the correct format."

        // Then
        XCTAssertTrue(sut.startFetching)
        XCTAssertEqual(sut.catchRequests.count, 1)
        XCTAssertEqual(sut.catchRequests[0], request)
        XCTAssertEqual(receivedError, .decodingError(deccodingErrorMessage))
    }
    
    func test_successResponse() {
        // Given
        let sut = getWebService()

        let item1 = TestFactory.exercise(id: 1,
                                         uuid: "4371e111-5b1f-4679-968e-bb5d9a48ebe2",
                                         name: "Alzate Laterali",
                                         exerciseBase: 3,
                                         description: "desc",
                                         created: "2023-08-06T10:17:17.349574+02:00",
                                         variations: [1180,1183,1178])

        let item2 = TestFactory.exercise(id: 2,
                                         uuid: "0ac8ee82-5816-414c-ba9b-8a825527400d",
                                         name: "Alzate le gambe",
                                         exerciseBase: 3,
                                         description: "test",
                                         created: "2023-08-06T10:17:17.349574+02:00",
                                         variations: [1963,1185,1344])

        guard let jsonData = TestFactory.exerciseResponse(exercies: [item1,item2]) else { return }

        sut.response = Just(jsonData)
            .setFailureType(to: WebServiceRequestError.self)
            .eraseToAnyPublisher()

        var receivedItems: ExercisesResponse?

        // When
        _ = sut.fetch(type: ExercisesResponse.self, router: .getExercises)
            .sink(receiveCompletion: { _ in }, receiveValue: { items in
                receivedItems = items
            })

        // Then
        XCTAssertNotNil(receivedItems)
        XCTAssertEqual(receivedItems?.results?.count, 2)
        XCTAssertEqual(receivedItems!.results?.first?.id, item1.id)
        XCTAssertEqual(receivedItems!.results?.first?.name, item1.name)
        XCTAssertEqual(receivedItems!.results?.last?.id, item2.id)
        XCTAssertEqual(receivedItems!.results?.last?.name, item2.name)
    }
    
    func test_successWithEmptyList() {
        // Given
        let sut = getWebService()
        guard let responseData = TestFactory.exerciseResponse(exercies: nil) else { return }
        sut.response = Just(responseData)
            .setFailureType(to: WebServiceRequestError.self)
            .eraseToAnyPublisher()

        var receivedItems: [Exercise]?

        // When
        _ = sut.fetch(type: ExercisesResponse.self, router: .getExercises)
            .sink(receiveCompletion: { _ in }, receiveValue: { items in
                receivedItems = items.results
            })

        // Then
        XCTAssertTrue(sut.startFetching)
        XCTAssertNil(receivedItems)
    }
    
    // MARK: - Helpers
    private func getWebService(file: StaticString = #file, line: UInt = #line) -> MockWebService {
        let sut = MockWebService()
        return sut
    }

}
