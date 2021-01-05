//
//  HttpUtils.swift
//  instagram
//
//  Created by 张杰 on 2020/12/31.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON
import MBProgressHUD

struct AFSErrorinfo {
    var code = 0
    var message = ""
    var error = NSError()
}


typealias NetSuccessBlock<T: Mappable> = (_ value: T, JSON) -> Void
typealias NetFaildBlock = (AFSErrorinfo) -> Void
typealias AFSProgressBlock = (Double) -> Void


public enum Method {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

class ZRequestManager: NSObject {
    private var sessionManager: Session?
    static let share = ZRequestManager()
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        // sessionManager = Session.init
        
    }
}

extension ZRequestManager {
    func start(_ url: String, completion: @escaping (Bool, Result<WeathModel, Error>) -> Void) {
        let requestUrl = URL(string: url)!
        AF.request(requestUrl).responseJSON { (response) in
            switch response.result {
            case let .success(data):
                let model = WeathModel(JSONString: data as! String)
                completion(true, .success(model!))
            case let .failure(error):
                completion(true, .failure(error))
            }
        }
    }
}


