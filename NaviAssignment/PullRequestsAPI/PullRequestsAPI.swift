//
//  PullRequestsAPI.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import Foundation

enum PullRequestsAPI: APIData {
    case getPullRequests(owner: String, repo: String, page: Int)

    var scheme: HTTPScheme {
        switch self {
        case .getPullRequests:
            return .https
        }
    }

    var baseURL: String {
        switch self {
        case .getPullRequests:
            return "api.github.com"
        }
    }

    var path: String {
        switch self {
        case .getPullRequests(owner: let username, repo: let repoName, _):
            return "/repos/\(username)/\(repoName)/pulls"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getPullRequests:
            return .get
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getPullRequests(_, _, page: let pageNo):
            let params = [
                URLQueryItem(name: "state", value: "closed"),
                URLQueryItem(name: "per_page", value: "10"),
                URLQueryItem(name: "page", value: String(pageNo))
            ]

            return params
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getPullRequests:
            let values = [
                HTTPHeaderKeys.accept.rawValue: HeaderContentType.json.rawValue,
                HTTPHeaderKeys.authToken.rawValue: "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"
            ]

            return values
        }
    }
}
