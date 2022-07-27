//
//  PullRequestsRepository.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import Foundation

protocol PullRequestsRepositoryPrototcol {
    func getPullRequests(owner: String, repo: String, page: Int, completionHandler: @escaping (Result<[PullRequestsResponse], NetworkError>) -> Void)
}

class PullRequestsRepository: PullRequestsRepositoryPrototcol {
    let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func getPullRequests(owner: String, repo: String, page: Int, completionHandler: @escaping (Result<[PullRequestsResponse], NetworkError>) -> Void) {
        let endpoint = PullRequestsAPI.getPullRequests(owner: owner, repo: repo, page: page)
        apiClient.fetch(request: endpoint, keyDecodingStrategy: .useDefaultKeys, completionHandler: { (result: Result<[PullRequestsResponse], NetworkError>) in
            switch result {
            case .success(let response):
                completionHandler(.success(response))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
