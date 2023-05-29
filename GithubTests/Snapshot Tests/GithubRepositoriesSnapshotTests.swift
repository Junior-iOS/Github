//
//  GithubRepositoriesTests.swift
//  GithubTests
//
//  Created by NJ Development on 28/05/23.
//

@testable import Github
import Nimble
import Nimble_Snapshots
import Quick

final class GithubRepositoriesSnapshotTests: QuickSpec {
    private var recording = false

    override func spec() {
        var sut: RepositoriesViewController!

        describe("Opening the application") {
            context("on success") {
                it("loads the screen") {
//                    self.recording = true

                    sut = RepositoriesViewController()
                    sut.viewDidLoad()

                    sut.view.translatesAutoresizingMaskIntoConstraints = false
                    sut.view.widthAnchor.constraint(equalToConstant: 500).isActive = true
                    sut.view.heightAnchor.constraint(equalToConstant: 1_000).isActive = true

                    if self.recording {
                        expect(sut).toEventually(recordSnapshot(), timeout: .seconds(5))
                    } else {
                        expect(sut).toEventually(haveValidSnapshot(), timeout: .seconds(5))
                    }
                }
            }
        }
    }
}
