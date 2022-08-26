//
//  OnlyThemeList.swift
//  ThemeView_Practice
//
//  Created by 유재호 on 2022/08/18.
//

import SwiftUI

struct OnlyThemeList: View {
    
    let theme = [
        Theme(spotImage: "house.fill", title: "서울 근교 분위기 좋은 카페", heartCount: 12),
        Theme(spotImage: "house.fill", title: "도심 밖 한적한 카페", heartCount: 52),
        Theme(spotImage: "house.fill", title: "오션 뷰가 예쁜 레스토랑", heartCount: 12),
        Theme(spotImage: "house.fill", title: "감미로운 재즈를 들을 수 있는 바", heartCount: 7),
        Theme(spotImage: "house.fill", title: "조용히 혼술하기 좋은 술집", heartCount: 120)
    ]
    
    var body: some View {
        VStack{
        List(theme) { model in
            HStack(spacing: 0) {
                Image(systemName: model.spotImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.screenWidth * 48/375)
                    .padding(.trailing, 12)
                    .padding(.vertical, 4)
                VStack(alignment: .leading, spacing: 6.42) {
                    Text(model.title)
                    HStack{
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth * 16.15/375)
                            .foregroundColor(Color.red)
                        Text(String(model.heartCount)).font(.system(size: 12))
                        
                    }
                    
                }
                Spacer()
            }
        }.listStyle(GroupedListStyle())
            .onAppear{
                UITableView.appearance().contentInset.top = -35
                
            }
            Spacer()
            Button {
                
            }
            label :{
                Text("삭제하기")
                    .frame(width: UIScreen.screenWidth * 335/375, height: UIScreen.screenHeight * 56/811, alignment: .center)
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.87, green: 0.87, blue: 0.87)
                        .cornerRadius(8)
                                
                                
                                
                                
                    )}
            
        }
        
    }
}

struct OnlyThemeList_Previews: PreviewProvider {
    static var previews: some View {
        OnlyThemeList()
    }
}
