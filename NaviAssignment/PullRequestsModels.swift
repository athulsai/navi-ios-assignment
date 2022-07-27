//
//  PullRequestsModels.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import Foundation

struct PullRequestsResponse: Codable {
    let id = UUID()
    let title: String?
    let user: User?
    let createdAt, closedAt: Date?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title, user
        case closedAt = "closed_at"
    }
}

struct User: Codable {
    let login: String?
    let avatarURL: String?
    let gravatarID: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
    }
}

extension PullRequestsResponse: Hashable {
    static func == (lhs: PullRequestsResponse, rhs: PullRequestsResponse) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
