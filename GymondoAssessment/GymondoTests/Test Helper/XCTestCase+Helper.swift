//
//  XCTestCase+Helper.swift
//  GymondoTests
//
//  Created by psagc on 25/01/24.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "❌ object should have been deallocated. memory leak.", file: file, line: line)
        }
    }
}
