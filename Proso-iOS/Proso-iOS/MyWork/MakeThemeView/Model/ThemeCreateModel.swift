//
//  ThemeCreateModel.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/23.
//

import Foundation
import UIKit

struct ThemeCreateModel{
    var themeTitle: String
    var themeIntroduce: String
    var themeImgUrl: String
    var userId: Int
    var themeImage: UIImage
    
    init() {
        themeTitle = ""
        themeIntroduce = ""
        themeImgUrl = ""
        userId = 0
        themeImage = UIImage()
    }
}

struct ThemeResponseModel: Codable {
    let createdDate, modifiedDate: String
    let id: Int
    let themeTitle, themeIntroduce: String
    let themeImgURL: String
    let status: JSONNull?
    let user: ThemeResponseUser
    let countOfContents: Int

    enum CodingKeys: String, CodingKey {
        case createdDate, modifiedDate, id, themeTitle, themeIntroduce
        case themeImgURL = "themeImgUrl"
        case status, user, countOfContents
    }
}

// MARK: - User
struct ThemeResponseUser: Codable {
    let createdDate, modifiedDate: String
    let id, socialID: Int
    let userName: String
    let profileImgURL: String
    let socialType, status, refreshToken, role: String

    enum CodingKeys: String, CodingKey {
        case createdDate, modifiedDate, id
        case socialID = "socialId"
        case userName
        case profileImgURL = "profileImgUrl"
        case socialType, status, refreshToken, role
    }
}
