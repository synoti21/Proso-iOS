//
//  WrittenTheme.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/06.
//

import SwiftUI

struct MyPageTheme: View {
    @State var isShowingWrittenTheme = true
    @State var isRedGuideBar = true
    var body: some View {
        
        VStack {
            HStack{
                Button {
                    isShowingWrittenTheme = true
                    isRedGuideBar = true
                } label: {
                    VStack{
                        Text("작성한 테마")
                            .font(.system(size: 18))
                            .bold()
                            .padding(.top, 28)
                        if isRedGuideBar == true{
                        Rectangle()
                            .frame(width: UIScreen.screenWidth * 162/375, height: UIScreen.screenHeight*5/811)
                            .foregroundColor(.red)
                        } else {
                            Rectangle()
                                .frame(width: UIScreen.screenWidth * 162/375, height: UIScreen.screenHeight*5/811)
                                .foregroundColor(.white)
                        }
                        
                        
                        

                    }
                    
                }
                
                
                
                Spacer()
                
                Button {
                    isShowingWrittenTheme = false
                    isRedGuideBar = false
                } label: {
                    VStack{
                        Text("찜한 테마")
                            .font(.system(size: 18))
                            .bold()
                            .padding(.top, 28)
                        if isRedGuideBar == true {
                        Rectangle()
                            .frame(width: UIScreen.screenWidth * 162/375, height: UIScreen.screenHeight*5/811)                            .foregroundColor(.white)
                        } else {
                        Rectangle()
                                .frame(width: UIScreen.screenWidth * 162/375, height: UIScreen.screenHeight*5/811)                            .foregroundColor(.red)
                        }
                        
                    }
                    
                }
                
                
                
                
                
                
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            if isShowingWrittenTheme == true {
                OnlyThemeList()
            }
            if isShowingWrittenTheme == false {
                OnlyBookmarkThemeList()
            }
            
            
            
        }
        
        
    }
}

struct MyPageTheme_Previews: PreviewProvider {
    static var previews: some View {
        MyPageTheme()
    }
}


