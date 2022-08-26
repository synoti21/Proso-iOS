//
//  ThemeSuggestionService.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/21.
//

import Foundation
import KakaoSDKUser
import Alamofire

struct ThemeSuggestionService {
    
    static let shared = LoginService()
    

    
    
    func getThemeArray(_ type: String, completion: @escaping(ThemeSuggestionModel)->() ){
        
        let urlCategory: String
        
        switch(type){
        case "카페": urlCategory = "/main/cafe"
        case "맛집": urlCategory = "/main/restaurant"
        default:
            urlCategory = ""
        }
        
        let url: String = APIConstants.baseURL + "/theme" + urlCategory
        print(url)
        /*let header = NetworkInfo.headerWithRefreshToken
        let obj = RefreshTokenModel(socialID: 0, accessToken: "0", refreshToken: "0")*/
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: nil,
                                     encoding: JSONEncoding.default,
                                     headers: NetworkInfo.header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                switch networkResult {
                case .success(let respondThemeData):
                    print("loaded suggested theme")
                    completion(respondThemeData)
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
                print("Theme Suggestion Service Error")
            }
        }
    }
    
    
    
    
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<ThemeSuggestionModel> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ThemeSuggestionModel.self, from: data)
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



