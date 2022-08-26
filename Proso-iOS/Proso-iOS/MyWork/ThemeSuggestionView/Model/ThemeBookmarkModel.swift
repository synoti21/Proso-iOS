//
//  ThemeBookmarkModel.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/24.
//

import Foundation

struct ThemeBookmarkModel: Codable {
    let userID, themeID: Int
    let themeTitle, status: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case themeID = "themeId"
        case themeTitle, status
    }
}
