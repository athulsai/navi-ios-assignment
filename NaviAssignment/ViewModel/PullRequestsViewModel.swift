//
//  PullRequestsViewModel.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import Foundation

final class PullRequestsViewModel {

    let pullRequestsRepository: PullRequestsRepositoryPrototcol

    var page = 1

    private(set) var allPullRequests: [PullRequestsResponse] = []

    init(pullRequestsRepository: PullRequestsRepositoryPrototcol) {
        self.pullRequestsRepository = pullRequestsRepository
    }

    func getPullRequests(completionHandler: @escaping (NetworkError?) -> ()) {
        pullRequestsRepository.getPullRequests(owner: "twostraws", repo: "wwdc", page: page, completionHandler: {(result: Result<[PullRequestsResponse], NetworkError>) in
            switch result {
            case .success(let response):
                self.allPullRequests.append(contentsOf: response)
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error)
            }
        })
    }
}
