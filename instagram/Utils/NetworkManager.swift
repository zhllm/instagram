//
//  NetworkManager.swift
//  instagram
//
//  Created by 张杰 on 2021/1/3.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

private let NetworkAPIBaseURL = "https://pixabay.com/"

class NetworkManager {
    static let shared = NetworkManager()
    var commonHeaders: HTTPHeaders {[
        "key": "19323754-89ce0cee13361c697d0fe73e2"
    ]}
    private init() {}
    
    @discardableResult
    func requestGet(path: String,
                 parameters: Parameters?,
                 completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(
            NetworkAPIBaseURL + path,
            parameters: parameters,
            headers: commonHeaders) {
            $0.timeoutInterval = 15
        }.responseData { (response) in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(
            NetworkAPIBaseURL + path,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.prettyPrinted,
            headers: commonHeaders,
            requestModifier: {
                $0.timeoutInterval = 15
            }
        ).responseData { (response) in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
