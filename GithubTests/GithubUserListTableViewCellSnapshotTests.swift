//
//  GithubUserListTableViewCellSnapshotTests.swift
//  GithubTests
//
//  Created by NJ Development on 28/05/23.
//

@testable import Github
import Nimble
import Nimble_Snapshots
import Quick

final class GithubUserListTableViewCellSnapshotTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: UserListTableViewCell!
        let user = User(login: "mojombo",
                        avatar: "https://avatars.githubusercontent.com/u/1?v=4",
                        detail: "https://api.github.com/users/mojombo",
                        repos: "https://api.github.com/users/mojombo/repos")

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = UserListTableViewCell()
                    sut.configure(user: user)

                    sut.translatesAutoresizingMaskIntoConstraints = false
                    sut.widthAnchor.constraint(equalToConstant: 300).isActive = true
                    sut.heightAnchor.constraint(equalToConstant: 100).isActive = true

                    if self.recording {
                        expect(sut).toEventually(recordSnapshot(), timeout: .seconds(3))
                    } else {
                        expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(3))
                    }
                }
            }
        }
    }
}
