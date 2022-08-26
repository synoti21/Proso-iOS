//
//  HashTagModel.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/08.
//

// MARK: - HashTag 구조체 선언
import Foundation

struct MakeThemeDefaultHashTag{
    let category: String
    let context: String
    
    init(_ categoryInput: String, _ contextInput: String){
        category = categoryInput
        context = contextInput
    }
}

struct MakeThemeDefaultHashTagModel{
    let defaultFoodHashTag =
    [
        MakeThemeDefaultHashTag("food", "분위기 좋은"),
        MakeThemeDefaultHashTag("food", "데이트코스"),
        MakeThemeDefaultHashTag("food", "점심식사"),
        MakeThemeDefaultHashTag("food", "저녁식사"),
        MakeThemeDefaultHashTag("food", "맛집"),
        MakeThemeDefaultHashTag("food", "회식장소"),
        MakeThemeDefaultHashTag("food", "혼밥")
    ]
    
    let defaultCafeHashTag =
    [
        MakeThemeDefaultHashTag("cafe", "디저트 맛집"),
        MakeThemeDefaultHashTag("cafe", "감성있는"),
        MakeThemeDefaultHashTag("cafe", "힐링"),
        MakeThemeDefaultHashTag("cafe", "조용한"),
        MakeThemeDefaultHashTag("cafe", "데이트코스"),
        MakeThemeDefaultHashTag("cafe", "인스타")
    ]
    
    let defaultActivityHashTag =
    [
        MakeThemeDefaultHashTag("activity", "축제"),
        MakeThemeDefaultHashTag("activity", "원데이 클래스"),
        MakeThemeDefaultHashTag("activity", "공연"),
        MakeThemeDefaultHashTag("activity", "데이트코스"),
    ]
    
    
    func getDefaultHashTag(_ category: String) -> [MakeThemeDefaultHashTag]{ ///해쉬태그 배열을 가져오기 위한 함수 선언
        switch(category){
        case "food":
            return defaultFoodHashTag
        case "cafe":
            return defaultCafeHashTag
        default :
            return defaultActivityHashTag
        }
    }
}
