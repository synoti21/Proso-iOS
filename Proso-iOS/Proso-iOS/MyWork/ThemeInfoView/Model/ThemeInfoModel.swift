//
//  ThemeUserModel.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/17.
//



import Foundation


// MARK: - DataClass
struct ThemeInfoModel: Codable {
    let themeTitle, themeIntroduce, themeImgURL: String
    let themeID, userID: Int
    let userName: String
    let contentCount, bookmarkCount: Int

    enum CodingKeys: String, CodingKey {
        case themeTitle, themeIntroduce
        case themeImgURL = "themeImgUrl"
        case themeID = "themeId"
        case userID = "userId"
        case userName, contentCount, bookmarkCount
    }
}
