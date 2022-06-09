//
//  Networking.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//

import UIKit
 
enum Result<Value: Decodable> {
    case success(Value)
    case failure(Bool)
}

typealias Handler = (Result<Data>) -> Void

enum NetworkError: Error {
    case nullData
}


public enum Method {
    case get
}

enum NetworkingError: String, LocalizedError {
    case jsonError = "JSON error"
    case other
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}

extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "GET":
            self = .get
        default:
            self = .get
        }
}
}
extension Method: CustomStringConvertible {
    public var description: String {
        switch self {
        case .get:   return "GET"
        }
    }
}

protocol Requestable {}

extension Requestable {

    internal func request(method: Method, url: String, params: [NSString: Any]? = nil, callback: @escaping Handler) {
        guard let url = URL(string: url) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url,  completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        if data != nil {
                            callback(.success(data!))
                        } else {
                            callback(.failure(true))
                        }
                    } else {
                        callback(.failure(true))
                    }
                }
            }
        })
        task.resume()
    }
}
