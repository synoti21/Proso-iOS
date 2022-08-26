//
//  LoginService.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/18.
//

import Foundation
import KakaoSDKUser
import Alamofire

struct LoginService {
    
    static let shared = LoginService()
    
    private func makeParameter(accessToken : String) -> Parameters {
        return ["accessToken" : accessToken]
    }
    
    
    func kakaoLogin(completion: @escaping () -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            print("start")
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                
                if let error = error {
                    
                    print(error)
                }
                else {
                    guard let kakaoData = oauthToken else { return }
                    let url: String = APIConstants.loginURL
                    let dataRequest = AF.request(url,
                                                 method: .post,
                                                 parameters: makeParameter(accessToken: kakaoData.accessToken),
                                                 encoding: JSONEncoding.default)
                    dataRequest.responseData { dataResponse in
                        switch dataResponse.result {
                        case .success:
                            guard let statusCode = dataResponse.response?.statusCode else {return}
                            guard let value = dataResponse.value else {return}
                            let networkResult = self.judgeStatus(by: statusCode, value)
                            switch networkResult {
                            case .success(let loginData):
                                if let accessToken = loginData.data.accessToken.data(using: String.Encoding.utf8){
                                    //print(loginData.data)
                                    print("token Area")
                                    print("======================================")
                                    print(loginData.data.accessToken)
                                    print("======================================")
                                    KeyChain.save(key: "token", data: accessToken)
                                    completion()
                                }
                            case .requestErr(_):
                                print("requestErr")
                            case .pathErr:
                                print("pathErr")
                            case .serverErr:
                                print("serverErr")
                            case .networkFail:
                                print("networkFail")
                            }
                        case .failure:
                            print("error")
                        }
                    }
                }
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<CommonRespons<LoginModel>> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CommonRespons<LoginModel>.self, from: data)
        else {
            return .pathErr}
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
}
