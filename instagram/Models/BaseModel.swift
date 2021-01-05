//
//  BaseModel.swift
//  instagram
//
//  Created by 张杰 on 2021/1/1.
//

import UIKit
import ObjectMapper

struct BaseModel<T: Mappable>: Mappable {
    
    var status: Int = 100
    var msg: String = ""
    // 返回数据
    var data: [T]?
    var dataAny: String?
    var dataStr: [String]?
    var dicData: T?
    var success: Int = 1
    var pageNo: Int?
    var totalPages: Int?
    var hasNextPage: Bool = false
    var total: Int?{
        didSet {
            if self.total == nil {
                self.total = 0
            } else {
                if self.total! % 10 == 0 {
                    self.total = Int(self.total! / 10)
                } else {
                    self.total = Int(self.total! / 10) + 1
                }
            }
        }
    }
    
    
    
    init?(map: Map) {
            
    }
    
    mutating func mapping(map: Map) {
        status              <- map["status"]
        status              <- map["status"]
        data                <- map["data"]
        dataStr             <- map["data"]
        data                <- map["data.data"]
        data              <- map["Data"]
        dataAny              <- map["Data"]
        dataAny              <- map["data"]
        success              <- map["success"]
        totalPages              <- map["data.totalPages"]
        total              <- map["data.totalRecord"]
        msg              <- map["msg"]
    }
}
