//
//  APIClientProtocol.swift
//  NaviAssignment
//
//  Created by Athul Sai on 25/07/22.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Codable>(request: APIData,
                             basePath: String,
                             keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
                             completionHandler: @escaping ((Result<T, NetworkError>) -> Void))
}
