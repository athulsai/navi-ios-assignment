//
//  PullRequestsViewControllerTests.swift
//  PullRequestsViewControllerTests
//
//  Created by Athul Sai on 28/07/22.
//

@testable import NaviAssignment
import XCTest

class PullRequestsViewControllerTests: XCTestCase {

    func test_outlets_shouldBeConnected() {
        let diContainer = AppDependencyContainer()
        let sut: PullRequestsViewController = diContainer.makePullRequestsViewController()
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.collectionView, "UICollectionView")
    }
}
