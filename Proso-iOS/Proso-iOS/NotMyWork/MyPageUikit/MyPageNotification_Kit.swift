//
//  MyPageNotification.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/14.
//


import UIKit
import SnapKit
import SwiftUI

class MyPageNotification_Kit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let myPageNotification = UIHostingController(rootView: MyPageNotification())
        myPageNotification.view.frame = view.bounds
        addChild(myPageNotification)
        view.addSubview(myPageNotification.view)
        
    }
//
//    private func settingNavigationBarAndTabBar() {
//        self.tabBarController?.tabBar.isHidden = true
//        let standardAppearance = UINavigationBarAppearance()
//        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        standardAppearance.backgroundColor = .white
//        self.navigationController?.navigationBar.standardAppearance = standardAppearance
//        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
//
//
//        title = "알림"
//    }
//
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.navigationController?.setUpNavigationItems(items: [.back, .delete])
//    }


}




