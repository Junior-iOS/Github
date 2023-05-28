//
//  GithubTests.swift
//  GithubTests
//
//  Created by NJ Development on 25/05/23.
//

import XCTest
@testable import Github

final class GithubTests: XCTestCase {

    private var mockService: NetworkProviderMock!
    private var sut: UserListViewModel!
    
    private var user = User(login: "mojombo",
                            avatar: "https://avatars.githubusercontent.com/u/1?v=4",
                            detail: "https://api.github.com/users/mojombo",
                            repos: "https://api.github.com/users/mojombo/repos")

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = NetworkProviderMock()
        sut = UserListViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchUsers() {
        let endpoint: GithubEndpoint = .searchList()
        guard let url = endpoint.url else { return }
        let resource = Resource<[User]>(url: url)
        
        mockService.load(resource: resource) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            default:
                XCTFail()
            }
        }
    }
    
    func testFetchUsersFailed() {
        guard let url = URL(string: "https://api.github.com/user") else { return }
        let resource = Resource<[User]>(url: url)
        mockService.isSuccess = false
        
        mockService.load(resource: resource) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            default:
                XCTFail()
            }
        }
    }
    
    func testFetchUsersDetails() {
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
    
    func testFetchRepos() {
        guard let repos = user.repos, let url = URL(string: repos) else { return }
        let resource = Resource<[Repository]>(url: url)
        
        mockService.load(resource: resource) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            default:
                XCTFail()
            }
        }
    }
    
    func testFetchReposFailed() {
        let repos: String? = "https://api.github.com/users/mojombo/repo"
        
        guard let repos = repos,
              let url = URL(string: repos) else { return }
        let resource = Resource<[Repository]>(url: url)
        
        mockService.isSuccess = false
        mockService.load(resource: resource) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            default:
                XCTFail()
            }
        }
    }
}

extension XCTestCase {
    enum Timeout {
        static var value = 30.0
    }
}
