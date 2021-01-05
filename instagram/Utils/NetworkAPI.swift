//
//  NetworkAPI.swift
//  instagram
//
//  Created by 张杰 on 2021/1/3.
//

import Foundation

class NetworkAPI {
    static func imagePostList(
        params: [String: Any]? = nil,
        completion: @escaping (Result<PostList, Error>) -> Void) {
        var parameters: [String: Any] = [
            "q": "yellow+flowers",
            "image_type": "photo",
            "pretty": "true",
            "key": "19323754-89ce0cee13361c697d0fe73e2"
        ]
        if params != nil {
            for (key, value) in params! {
                parameters[key] = value
            }
        }
        NetworkManager.shared.requestGet(path: "api", parameters: parameters) { (reslut) in
            switch reslut {
            case let .success(data):
                let jsonString = String(data: data, encoding: .utf8)
                guard jsonString != nil, let mode = PostList.init(JSONString: jsonString!) else {
                    let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [
                        NSLocalizedDescriptionKey: "Can not parse data"
                    ])
                    completion(.failure(error))
                    return
                }
                completion(.success(mode))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
