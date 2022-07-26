//
//  APIClient.swift
//  NaviAssignment
//
//  Created by Athul Sai on 25/07/22.
//

import Foundation

class APIClient: APIClientProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetch<T: Codable>(request: APIData, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, completionHandler: @escaping ((Result<[T], NetworkError>) -> Void)) {
        self.networkManager.startRequest(request: request) { (data, response, error) in

            if let _ = error{
                let errorType = NetworkError.failed
                completionHandler(.failure(errorType))
                return
            }

            guard let responseData = response as? HTTPURLResponse,
                let receivedData = data else{
                    let errorType = NetworkError.noResponseData
                    completionHandler(.failure(errorType))
                    return
            }

            let responseStatus = self.isValidResposne(response: responseData)
            switch responseStatus {
            case .success:
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
                jsonDecoder.dateDecodingStrategy = .iso8601
                do {
                    let apiResponseModel = try jsonDecoder.decode([T].self, from: receivedData)
                    completionHandler(.success(apiResponseModel))
                } catch {
                    completionHandler(.failure(NetworkError.unableToDecodeResponseData(errorDescription: error.localizedDescription)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func isValidResposne(response: HTTPURLResponse) -> Result<String, NetworkError>{
        switch response.statusCode{
        case 200...299:
            return .success("Valid Response")
        case 401:
            return .failure(NetworkError.authenticationError)
        case 500:
            return .failure(NetworkError.badRequest)
        default:
            return .failure(NetworkError.failed)
        }
    }
}
