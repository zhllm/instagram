//
//  WeatherModel.swift
//  instagram
//
//  Created by 张杰 on 2021/1/2.
//

import Foundation
import ObjectMapper

struct WeathModel: Mappable {
    
    var main: WeatherMainModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        main <- map["main"]
    }
    
}

struct WeatherMainModel: Mappable {
    
    var tempetature: Float?
    var temperatureMax: Float?
    var temperatureMin: Float?
    var pressure: Float?
    var humidity: Float?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        tempetature <- map["temp"]
        temperatureMax <- map["temp_max"]
        temperatureMin <- map["temp_min"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
}
