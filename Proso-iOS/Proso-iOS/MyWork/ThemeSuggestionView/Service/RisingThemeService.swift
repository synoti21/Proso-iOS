//
//  ThemeSuggestionService.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/21.
//

import Foundation
import KakaoSDKUser
import Alamofire

struct RisingThemeService {
    
    static let shared = LoginService()
    

    
    
    func getThemeArray(completion: @escaping(ThemeRisingModel)->() ){
       
        let url: String = APIConstants.baseURL + "/theme/main/top"
        print(url)
        
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
                    print("loaded rising theme")
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
                print("Rising Theme Service Error")
            }
        }
    }
    
    
    
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<ThemeRisingModel> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ThemeRisingModel.self, from: data)
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
