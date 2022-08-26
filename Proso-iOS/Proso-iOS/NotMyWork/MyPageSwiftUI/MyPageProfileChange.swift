//
//  ProfileChange.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/06.
//

import SwiftUI

struct MyPageProfileChange: View {
    @State var name: String = ""
    var body: some View {
        
        VStack(spacing: 0){
            Image("image_userprofile_120px").resizable().aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.screenWidth * 120/375)
                .padding(.top, 28)
    
    
                Text("닉네임을 입력해주세요").font(.system(size: 18, weight: .bold, design: .default))
                .frame(minWidth: 0, idealWidth: 176, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.vertical, 28)
    
                   
                TextField("여기에 입력해주세요", text: $name)
                        .font(.system(size: 14))
                        .background(Color.white)
                        .padding(.horizontal,20)
                        .padding(.bottom,8)
            Rectangle().frame(minWidth: 335, idealWidth: 335, maxWidth: .infinity, minHeight: 0, idealHeight: 1, maxHeight: 1, alignment: .center)
                .foregroundColor(Color(red: 0.86, green: 0.86, blue: 0.86))
                .padding(.horizontal,20)
            
            HStack(spacing:0){
            Spacer()
            Text("0/10")
                    .foregroundColor(Color(red: 0.40, green: 0.40, blue: 0.40))
                .font(.system(size: 12))
                
                .padding(.top,10)
                .padding(.trailing, 20)
                
            }
            Spacer()
            
                Button {
                    
                } label: {
                    Text("완료")
                      
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0,
                                idealWidth: 100,
                                maxWidth: .infinity,
                                minHeight: 0,
                                idealHeight: 100,
                                maxHeight: 100,
                                alignment: .center)
                        .aspectRatio(335/56, contentMode: .fit)
                        .background(Color(red: 0.87, green: 0.87, blue: 0.87))
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                }

            }
        
    }
}

struct MyPageProfileChange_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfileChange()
    }
}

