//
//  PostList.swift
//  instagram
//
//  Created by 张杰 on 2021/1/3.
//

import Foundation
import ObjectMapper

struct PostList: Mappable {
    
    var hits: [Post]?
    var total: Int?
    var totalHits: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hits <- map["hits"]
        total <- map["total"]
        totalHits <- map["totalHits"]
    }
}

struct Post: Mappable {
    var id: Int?
    var pageURL: String?
    var type: String?
    var tags: String?
    var previewURL: String?
    var previewWidth: Float?
    var previewHeight: Float?
    var webformatURL: String?
    var webformatWidth: Float?
    var webformatHeight: Float?
    var largeImageURL: String?
    var imageWidth: Float?
    var imageHeight: Float?
    var imageSize: Float?
    var views: Int?
    var downloads: Int?
    var favorites: Int?
    var likes: Int?
    var comments: Int?
    var user_id: Int?
    var user: String?
    var userImageURL: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        pageURL <- map["pageURL"]
        type <- map["type"]
        tags <- map["tags"]
        previewURL <- map["previewURL"]
        previewWidth <- map["previewWidth"]
        previewHeight <- map["previewHeight"]
        webformatURL <- map["webformatURL"]
        webformatWidth <- map["webformatWidth"]
        webformatHeight <- map["webformatHeight"]
        largeImageURL <- map["largeImageURL"]
        imageWidth <- map["imageWidth"]
        imageHeight <- map["imageHeight"]
        imageSize <- map["imageSize"]
        views <- map["views"]
        downloads <- map["downloads"]
        favorites <- map["favorites"]
        likes <- map["likes"]
        comments <- map["comments"]
        user_id <- map["user_id"]
        user <- map["user"]
        userImageURL <- map["userImageURL"]
    }
}
