//
//  GithubRequestErrorTests.swift
//  GithubTests
//
//  Created by NJ Development on 28/05/23.
//

import XCTest
@testable import Github

final class GithubRequestErrorTests: XCTestCase {
    func testLocalizedDescription() {
        XCTAssertEqual(NetworkError.decodingError.localizedDescription, "Failed to decode data")
        XCTAssertEqual(NetworkError.domainError.localizedDescription, "No data")
        XCTAssertEqual(NetworkError.urlError.localizedDescription, "Failed to read URL")
        XCTAssertEqual(NetworkError.mappingError.localizedDescription, "Failed to map the object")
    }
}
