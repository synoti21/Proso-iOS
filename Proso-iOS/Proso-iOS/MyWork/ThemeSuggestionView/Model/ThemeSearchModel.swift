//
//  ThemeSearchTableViewData.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/16.
//

import Foundation

// MARK: - Datum
struct ThemeSearchModel: Codable {
    let themeTitle, themeIntroduce, themeImgURL: String
    let themeID, userID: Int
    let userName: String

    enum CodingKeys: String, CodingKey {
        case themeTitle, themeIntroduce
        case themeImgURL = "themeImgUrl"
        case themeID = "themeId"
        case userID = "userId"
        case userName
    }
}
