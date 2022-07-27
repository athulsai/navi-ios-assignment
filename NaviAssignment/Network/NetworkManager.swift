//
//  NetworkManager.swift
//  NaviAssignment
//
//  Created by Athul Sai on 25/07/22.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared

    private init() { }

    func startRequest(request: APIData, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        do {
            let urlRequest = try self.createURLRequest(apiData: request)

            task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            task?.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
}

private extension NetworkManager {
    private func createURLRequest(apiData: APIData) throws -> URLRequest {
        let components = buildURL(endpoint: apiData)
        if let url = components.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = apiData.method.rawValue
            self.addRequestHeaders(request: &urlRequest, requestHeaders: apiData.headers)
            return urlRequest
        } else {
            throw NetworkError.malformedURL
        }
    }

    private func addRequestHeaders(request: inout URLRequest, requestHeaders: [String: String]?) {
        guard let headers = requestHeaders else{
            return
        }

        for (key, value) in headers  {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    private func buildURL(endpoint: APIData) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        return components
    }
}
