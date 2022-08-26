//
//  Token.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/26.
//

import Foundation
/*
struct Token{
    func refreshToken() {
            let url: String = APIConstants.refreshTokenURL
            let header = NetworkInfo.headerWithRefreshToken
            let dataRequest = AF.request(url,
                                         method: .post,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            dataRequest.responseData { dataResponse in
                switch dataResponse.result {
                case .success:
                    guard let statusCode = dataResponse.response?.statusCode else {return}
                    guard let value = dataResponse.value else { return }
                    let obj = RefreshTokenModel(socialID: 0, accessToken: "0", refreshToken: "0")
                    judgeStatus(by: statusCode, value, obj) { networkResult in
                        print(networkResult)
                    }
                case .failure:
                    print("error")
                }
            }
            
        }
        
        
        private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data,_ dataOBJ: T, completion: @escaping (CommonRespons<T>) -> Void) {
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(CommonRespons<T>.self, from: data) else { return }
            switch statusCode {
            case 200: completion(decodedData)
            case 400: break
            case 500: break
            default: break
            }
        }
}
*/
