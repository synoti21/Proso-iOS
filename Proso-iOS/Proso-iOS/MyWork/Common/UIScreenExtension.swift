//
//  UIScreenExtension.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/15.
//



//기기 스크린 넓이를 대응하기 위한 extension
import Foundation
import UIKit

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
