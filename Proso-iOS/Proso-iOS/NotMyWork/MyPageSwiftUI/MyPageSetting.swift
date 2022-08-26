//
//  MyPage.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/06.
//

import SwiftUI
//
//class ChildHostingController: UIHostingController<MyPage> {
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder,rootView: MyPage());
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}


// 사용



struct MyPageSetting: View {
    
    let settinglist = ["문의하기", "알림설정", "버전정보","개인정보 처리방침", "서비스 이용약관"]
    var body: some View {
        
        VStack(spacing:0){
            
            ZStack {
                Rectangle().foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                VStack(spacing:0){
                    Button {
                        
                    } label: {
                        ZStack{
                            Image("image_userprofile_120px").resizable().aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth * 120/375)
                                .padding(.top, 28)
                            
                            
                            
                        }
                        
                    }
                    
                    Text("비니").font(.largeTitle).bold()
                        .padding(.top, 16)
                    Spacer(minLength: 8)
                    
                    Text("카카오톡 회원")
                    Spacer(minLength: 28)
                    HStack(spacing: 0){
                        Spacer(minLength: 20)
                        ZStack(alignment: .topLeading){
                            Rectangle()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth * 104/375)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            VStack(spacing:0){
                                Text("나의 P테마")
                                    .font(.system(size: 12))
                                    .lineLimit(2)
                                    .padding([.leading, .top], 12)
                                    .padding(.trailing, 62)
                                
                            }
                            
                        }
                        Spacer(minLength: 12)
                        
                        ZStack(alignment: .topLeading){
                            Rectangle()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth * 104/375)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Text("작성한 리뷰")
                                .font(.system(size: 12))
                                .lineLimit(2)
                                .padding([.leading, .top], 12)
                                .padding(.trailing, 58)
                            
                            
                        }
                        Spacer(minLength: 12)
                        
                        
                        ZStack(alignment: .topLeading){
                            Rectangle()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth * 104/375)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            
                            Text("친구 목록")
                                .font(.system(size: 12))
                                .lineLimit(2)
                                .padding([.leading, .top], 12)
                                .padding(.trailing, 45)
                            
                            
                            
                        }
                        Spacer(minLength: 20)
                        
                        
                        
                        
                    }.padding(.bottom,24)
                    
                    
                }
            }
            List {
                
                ForEach(settinglist, id: \.self) { text in
                    NavigationLink(destination: Text("Second view")) {
                        Text(text)
                        
                    }
                }
            }
            .listStyle(.grouped)
            .onAppear { //list의 top padding 제거
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableView.appearance().contentInset.top = -35
                
            }

            
        }
//        UinavigationController?.setUpNavigationItems(items: [.logo, .bell])
    }
}




struct MyPageSetting_Previews: PreviewProvider {
    static var previews: some View {
        MyPageSetting()
    }
}

