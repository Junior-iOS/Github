//
//  GithubUserListTests.swift
//  GithubTests
//
//  Created by NJ Development on 28/05/23.
//

import XCTest
@testable import Github

final class GithubUserListTests: XCTestCase {

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
        let endpoint: Endpoint = .searchList()
        guard let url = endpoint.url else { return }
        let resource = Resource<[User]>(url: url)
        
        mockService.load(resource: resource) { result in
            switch result {
            case .success(let data):
                self.sut.users = data
                XCTAssertNotNil(data)
            default:
                XCTFail()
            }
        }
        
        sut.fetchUsers(.searchList())
        XCTAssertEqual(user, sut.users?[0])
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
        
        sut.fetchUsers(.searchList())
        XCTAssertNil(sut.users?[0])
    }
    
    func testDidSelectUser() {
        let viewModel = user
        let selectedUser = sut.didSelectUserAt(index: 0)

        guard let firstUser = selectedUser else { return }
        XCTAssertEqual(viewModel, firstUser)
    }
}
