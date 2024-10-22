//
//  APIService.swift
//  Workout
//
//  Created by Viet Phan on 21/10/24.
//

import Foundation
import Alamofire
import Combine

protocol APIServiceType {
    func request(_ endpoint: APIEndpoint) -> AnyPublisher<Any, APIError>
}

class APIService: APIServiceType {
    
    private let session: Session
    private let networkMonitor = NetworkMonitor.shared

    init() {
        self.session = Session()
    }


    func request(_ endpoint: APIEndpoint) -> AnyPublisher<Any, APIError> {
        return request(api: endpoint.fullPath,
                       isPublic: endpoint.isPublic,
                       method: endpoint.method,
                       parameters: endpoint.params,
                       headers: endpoint.headers,
                       encoding: endpoint.encoding)
    }
    
    func request(api: String,
                 isPublic: Bool,
                 method: HTTPMethod,
                 parameters: Parameters? = nil,
                 headers: HTTPHeaders? = nil,
                 encoding: ParameterEncoding) -> AnyPublisher<Any, APIError> {
        guard networkMonitor.hasConnection else {
            return Fail(error: APIError(errorMessage: Strings.Common.noNetwork)).eraseToAnyPublisher()
        }
        return Future { promise in
            self.session.request(api, method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: headers,
                                 interceptor: nil, //This is a demo version application and does not have authentication so there is no interceptor handling
                                 requestModifier: nil)
            .validate(statusCode: 200..<400)
            .responseString { response in
                switch response.result {
                case .success(let string):
                    if let data: Data = string.data(using: .utf8),
                       let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
                        promise(.success(json))
                    } else {
                        promise(.success(string))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    if let apiError: APIError = DecodeUtils.decode(data: response.data) {
                        promise(.failure(apiError))
                    } else {
                        promise(.failure(APIError.commonError))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
