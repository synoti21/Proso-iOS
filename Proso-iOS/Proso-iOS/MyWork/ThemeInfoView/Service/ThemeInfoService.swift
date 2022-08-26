//
//  ThemeSuggestionService.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/21.
//

import Foundation
import KakaoSDKUser
import Alamofire

struct ThemeInfoService {
    
    static let shared = LoginService()
    
    private func makeParameter(id : Int) -> Parameters {
        return ["themeId" : id]
    }
    
    func getThemeArray(_ themeID: Int, completion: @escaping(ThemeInfoModel)->() ){
        
        let url: String = APIConstants.baseURL + "/theme/keyword"
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: makeParameter(id: themeID),
                                     encoding: URLEncoding(destination: .queryString),
                                     headers: NetworkInfo.header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                switch networkResult {
                case .success(let respondSearchData):
                    print("loaded Theme Info")
                    completion(respondSearchData.data)
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
                print("Search Service Error")
            }
        }
    }
    
    
    
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<CommonRespons<ThemeInfoModel>> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CommonRespons<ThemeInfoModel>.self, from: data)
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
