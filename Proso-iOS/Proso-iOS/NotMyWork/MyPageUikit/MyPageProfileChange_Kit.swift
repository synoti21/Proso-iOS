//
//  MyPageProfileChanged_Kit.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/14.
//


import UIKit
import SnapKit
import SwiftUI
class MyPageProfileChange_Kit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let myPageProfileChange = UIHostingController(rootView: MyPageProfileChange())
        myPageProfileChange.view.frame = view.bounds
        addChild(myPageProfileChange)
        view.addSubview(myPageProfileChange.view)
        
    }
    
    private func settingNavigationBarAndTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        standardAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        
        
        title = "프로필 수정"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingNavigationBarAndTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setUpNavigationItems(items: [.back])
    }

    

}




