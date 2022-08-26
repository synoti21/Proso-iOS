//
//  Test_navi.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/14.
//

import UIKit
import SnapKit
import SwiftUI

class MyPageSetting_Kit: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setUpNavigationItems(items: [.logo, .bell, .setting])
        
        
        let myPageSetting = UIHostingController(rootView: MyPageSetting())
        myPageSetting.view.frame = view.bounds
        addChild(myPageSetting)
        view.addSubview(myPageSetting.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

 

}











