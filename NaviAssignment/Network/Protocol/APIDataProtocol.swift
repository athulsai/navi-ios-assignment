//
//  APIDataProtocol.swift
//  NaviAssignment
//
//  Created by Athul Sai on 25/07/22.
//

import Foundation

protocol APIData {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String]? { get }
}
