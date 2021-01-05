//
//  WeatherApi.swift
//  instagram
//
//  Created by 张杰 on 2021/1/2.
//

import Foundation
import Alamofire
import ObjectMapper

class WeatherApi {
    class func getData(stringUrl: String = "https://api.openweathermap.org/data/2.5/weather?q=london,uk&appid=097484ba569e0584f20cfbae5adb4e6d",
                       completion: @escaping (WeathModel?) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(nil)
            return
        }
        AF.request(url)
            .responseJSON { (res) in
//                debugPrint("--------" )
//                debugPrint(res.data ?? "")
//                debugPrint(res)
//                return
                let josnString = String(data: res.data!, encoding: .utf8)
                
                let model = WeathModel(JSONString: josnString!)
                print(model?.main?.toJSONString(prettyPrint: true) ?? "")
            }
    }
}
