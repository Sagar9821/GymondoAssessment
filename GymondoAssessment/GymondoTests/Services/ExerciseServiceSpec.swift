//
//  ExerciseServiceSpec.swift
//  GymondoTests
//
//  Created by psagc on 19/01/24.
//

import XCTest
import Combine
@testable import Gymondo

final class ExerciseServiceSpec: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    func test_endToEndTestServerGETExercisesResult_matchesAPIData() {
        let apiService: ExerciseService = ExerciseService()

        let exp = expectation(description: "Wait for completion")

        _ = apiService.fetchExercise()
            .sink { completion in
                switch completion {
                case .finished:
                    exp.fulfill()

                case let .failure(error):
                    XCTFail("Expected successful data result, got \(error) instead")
                }
        } receiveValue: { exerciseResponse in            
            XCTAssertTrue(((exerciseResponse.results?.contains(where: {$0.id == TestFactory.exercise(id: 31).id})) != nil))
        }
        wait(for: [exp], timeout: 10.0)
    }
    
  
    // MARK: - Helpers

    private func getExerciseService(file: StaticString = #file, line: UInt = #line) -> MockExerciseService {
        let apiService = MockExerciseService()
        return apiService
    }
}

