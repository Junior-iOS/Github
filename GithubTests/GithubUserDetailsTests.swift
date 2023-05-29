//
//  GithubUserDetailsTests.swift
//  GithubTests
//
//  Created by NJ Development on 29/05/23.
//

import XCTest
@testable import Github

final class GithubUserDetailsTests: XCTestCase {
    
    private var mockService: NetworkProviderMock!
    private var sut: UserDetailViewModel!
    
    private var user = User(login: "mojombo",
                            avatar: "https://avatars.githubusercontent.com/u/1?v=4",
                            detail: "https://api.github.com/users/mojombo",
                            repos: "https://api.github.com/users/mojombo/repos")
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = NetworkProviderMock()
        sut = UserDetailViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchDetail() {
        guard let userDetail = user.detail,
              let url = URL(string: userDetail) else { return }
        let resource = Resource<UserDetail>(url: url)
        
        mockService.load(resource: resource) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            default:
                XCTFail()
            }
        }
    }
}
