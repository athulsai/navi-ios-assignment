//
//  AppDependencyContainer.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import UIKit

class AppDependencyContainer {
    func makePullRequestsViewController() -> PullRequestsViewController {
        let pullRequestsRepository = makePullRequestsRepository()
        let pullRequestsViewModel = makePullRequestsViewModel(with: pullRequestsRepository)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(identifier: String(describing: PullRequestsViewController.self), creator: { coder in
            return PullRequestsViewController(coder: coder, viewModel: pullRequestsViewModel)
        })

        return searchVC
    }

    private func makePullRequestsViewModel(with repository: PullRequestsRepositoryPrototcol) -> PullRequestsViewModel {
        let pullRequestsViewModel = PullRequestsViewModel(pullRequestsRepository: repository)
        return pullRequestsViewModel
    }

    private func makePullRequestsRepository() -> PullRequestsRepository {
        let pullRequestsRepository = PullRequestsRepository(apiClient: APIClient())
        return pullRequestsRepository
    }
}
