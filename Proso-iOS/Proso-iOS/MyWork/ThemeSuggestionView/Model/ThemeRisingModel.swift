//
//  ThemeRisingModl.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/22.
//

import Foundation

struct ThemeRisingModel: Codable {
    let success: Bool
    let data: ThemeRisingData
    let error: JSONNull?
}

// MARK: - DataClass
struct ThemeRisingData: Codable {
    let themeTitle, themeImgURL: String
    let themeID: Int
    let userName: String

    enum CodingKeys: String, CodingKey {
        case themeTitle
        case themeImgURL = "themeImgUrl"
        case themeID = "themeId"
        case userName
    }
}
