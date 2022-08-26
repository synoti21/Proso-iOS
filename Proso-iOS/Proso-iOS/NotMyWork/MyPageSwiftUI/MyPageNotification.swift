//
//  notification.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/09.
//

import SwiftUI

struct MyPageNotification: View {
    let content = ["비니님이 즉흥약속 요청을 보냈습니다", "비니님이 리뷰를 작성했습니다.", "비니님이 친구요청을 보냈습니다"]
    var body: some View {
        List(content, id: \.self) { text in
            NavigationLink {
                
            } label: {
                HStack(spacing:0){
                
                Image("image_userprofile_42px")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth * 42/375)
                        .padding(.vertical, 16)
                        .padding(.trailing, 14)
                Text(text)
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        .frame(width: UIScreen.screenWidth * 149/375, height: UIScreen.screenHeight * 40/811, alignment: .leading)
                        .lineLimit(2)
                        .lineSpacing(2)

                    
                    
                  


                }
            }
            
            
        }.listStyle(GroupedListStyle())
            .onAppear { //list의 top padding 제거
//                  let tableHeaderView = UIView(frame: .zero)
//                  tableHeaderView.frame.size.height = 1
//                  UITableView.appearance().tableHeaderView = tableHeaderView
                UITableView.appearance().backgroundColor = UIColor.clear

                UITableView.appearance().contentInset.top = -35
                
            }
        
        
    }
}


struct MyPageNotification_Previews: PreviewProvider {
    static var previews: some View {
        MyPageNotification()
    }
}
