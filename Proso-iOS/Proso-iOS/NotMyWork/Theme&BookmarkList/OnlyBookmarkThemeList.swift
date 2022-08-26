//
//  OnlyBookmarkThemeList.swift
//  ThemeView_Practice
//
//  Created by 유재호 on 2022/08/18.
//

import SwiftUI

struct OnlyBookmarkThemeList: View {
    
    let theme = [
        Theme(spotImage: "house.fill", title: "서울 근교 분위기 좋은 카페", heartCount: 12),
        Theme(spotImage: "house.fill", title: "도심 밖 한적한 카페", heartCount: 52),
        Theme(spotImage: "house.fill", title: "오션 뷰가 예쁜 레스토랑", heartCount: 12)
    ]
    
    var body: some View {
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
        
    }
}

struct OnlyBookmarkThemeList_Previews: PreviewProvider {
    static var previews: some View {
        OnlyBookmarkThemeList()
    }
}
