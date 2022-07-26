//
//  NetworkConfig.swift
//  NaviAssignment
//
//  Created by Athul Sai on 25/07/22.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

public enum HTTPScheme: String {
    case http
    case https
}

enum HeaderContentType: String {
    case json = "application/vnd.github+json"
}

enum HTTPHeaderKeys: String {
    case accept = "Accept"
    case authToken = "Authorization"
}
