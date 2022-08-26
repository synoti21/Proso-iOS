//
//  LoginModel.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/18.
//

struct CommonRespons<model: Codable>: Codable {
    let success: Bool
    let data: model
    let error: JSONNull?
}

struct CommonResponsWithArray<model: Codable>: Codable {
    let success: Bool
    let data: [model]
    let error: JSONNull?
}

struct LoginModel: Codable {
    let accessToken, refreshToken: String
}



// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, refreshToken: String
}
