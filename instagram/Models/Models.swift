//
//  Models.swift
//  instagram
//
//  Created by 张杰 on 2020/12/18.
//

import Foundation

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let profilePhoto: URL
    let joinDate: Date
}

/// Respresent user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createDate: Date
    let taggeUsers: [User]
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public struct PostLikes {
    let username: String
    let postIdentifier: String
}

public struct CommentLikes {
    let username: String
    let commentIdentifier: String
}

public struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLikes]
}

public enum UserPostType {
    case photo, video
}
