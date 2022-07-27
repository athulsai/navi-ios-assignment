//
//  NetworkManagerProtocol.swift
//  NaviAssignment
//
//  Created by Athul Sai on 25/07/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func startRequest(request: APIData, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}
