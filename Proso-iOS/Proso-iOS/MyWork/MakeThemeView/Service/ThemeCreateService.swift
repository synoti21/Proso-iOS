//
//  ThemeSuggestionService.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/21.
//

import Foundation
import KakaoSDKUser
import Alamofire
import UIKit

struct ThemeCreateService {
    
    static let shared = LoginService()
    
    private func makeParameter(_ title : String, _ introduce: String, _ imgurl: String, _ userid: Int) -> Parameters {
        return [
            "themeTitle" : title,
            "themeIntroduce" : introduce,
            "themeImgUrl" : imgurl,
            "userId" : userid
        ]
    }
    
    func uploadTheme(_ theme: ThemeCreateModel, completion: @escaping () -> Void){
        
        let url: String = APIConstants.baseURL + "/theme/keyword"
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: makeParameter(theme.themeTitle, theme.themeIntroduce, theme.themeImgUrl, theme.userId),
                                     encoding: JSONEncoding.default,
                                     headers: NetworkInfo.header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                switch networkResult {
                case .success(let respondSearchData):
                    print(respondSearchData.data)
                    completion()
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
    
    func uploadImageFile(_ image: UIImage){
        let imageData = image.jpegData(compressionQuality: 0.50)
        
        print(image, imageData!)

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "upload_data" , fileName: "file.jpeg", mimeType: "image/jpeg")
            },
            to: APIConstants.baseURL + "/s3/file", method: .post , headers: NetworkInfo.header)
        .response { resp in
            print(resp)
        }
    }
    
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<CommonRespons<ThemeResponseModel>> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(CommonRespons<ThemeResponseModel>.self, from: data)
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
