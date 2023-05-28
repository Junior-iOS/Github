//
//  GithubRepositoriesTableViewCellTests.swift
//  GithubTests
//
//  Created by NJ Development on 28/05/23.
//

@testable import Github
import Nimble
import Nimble_Snapshots
import Quick

final class GithubRepositoriesTableViewCellTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: RepositoriesTableViewCell!
        
        let owner = Owner(name: "defunkt",
                          avatar: "https://avatars.githubusercontent.com/u/2?v=4")
        
        let repository = Repository(name: "ace",
                                    description: "Ajax.org Cloud9 Editor",
                                    stars: 16,
                                    forks: 7,
                                    owner: owner)

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = RepositoriesTableViewCell()
                    sut.configure(viewModel: repository)

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
