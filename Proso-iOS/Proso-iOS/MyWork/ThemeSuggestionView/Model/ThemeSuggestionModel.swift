//
//  ThemeModel.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/16.
//

import Foundation
import UIKit
import SnapKit

struct ThemeSuggestionModel: Codable {
    let success: Bool
    let data: [[ThemeSuggestionDatum]]
    let error: JSONNull?
}

// MARK: - Datum
struct ThemeSuggestionDatum: Codable {
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

