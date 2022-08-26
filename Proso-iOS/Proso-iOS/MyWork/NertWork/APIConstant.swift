//
//  APIConstant.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/18.
//

import Foundation
import Security
import Alamofire

struct APIConstants {
    
    static let authorization = "Authorization"
    static let accept = "Accept"
    static let auth = "x-auth-token"
    static let contentType = "Content-Type"

    static let applicationJSON = "application/json"
    static let formEncoded = "application/x-www-form-urlencoded"
    static let jwtToken = KeyChain.load(key: "token")
    
    // Base URL
    static let baseURL = "http://3.35.102.161:8080"
    static let loginURL = baseURL + "/auth/kakao"
    
}

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}


enum NetworkHeaderKey: String {
    case auth = "Authorization"
    case contentType = "Content-Type"
}

struct NetworkInfo {
    static let shared = NetworkInfo()
    static let token = APIConstants.jwtToken
    static var header: HTTPHeaders {
        [NetworkHeaderKey.auth.rawValue: "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJzdWIiOiIyMzkzNjc2NjU4IiwiaWF0IjoxNjYxMTY1NTMzLCJleHAiOjE2NjExODk1MzN9.laRFqVkWWCissAYxd4FbiyVnEAhO17jJmifPiMIUHzw"]
    }
}


class KeyChain {
    class func save(key: String, data: Data) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        SecItemDelete(query)
        SecItemAdd(query, nil)
    }
    
    class func load(key: String) -> Data? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query, UnsafeMutablePointer($0)) }
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data {
                return data
            }
        }
        return nil
    }
    
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        SecItemDelete(query)
    }
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
