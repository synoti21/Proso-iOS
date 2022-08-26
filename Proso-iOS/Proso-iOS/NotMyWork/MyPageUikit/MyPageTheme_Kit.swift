//
//  MyPageTheme_Kit.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/14.
//


import UIKit
import SnapKit
import SwiftUI

class MyPageTheme_Kit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let myPageTheme = UIHostingController(rootView: MyPageTheme())
        myPageTheme.view.frame = view.bounds
        addChild(myPageTheme)
        view.addSubview(myPageTheme.view)
        
    }

//    private func settingNavigationBarAndTabBar() {
//        self.tabBarController?.tabBar.isHidden = true
//
//        let standardAppearance = UINavigationBarAppearance()
//        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        standardAppearance.backgroundColor = .white
//        self.navigationController?.navigationBar.standardAppearance = standardAppearance
//        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
//        self.navigationController?.setUpNavigationItems(items: [.delete])
//
//        title = "나의 P테마"
//
//    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.navigationController?.setUpNavigationItems(items: [.back, .delete])
//    }
////
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//
//    }

    

}




