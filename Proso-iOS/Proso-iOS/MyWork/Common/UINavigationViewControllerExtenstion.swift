//
//  UINavigationViewControllerExtenstion.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/08.
//

import UIKit

extension UINavigationController {
    @objc func tappedBell(_ sender: Any){
        self.pushViewController(UIViewController(), animated: true)
    }
    @objc func tappedAdd(_ sender: Any){
        let rootVC = MakeThemeFirstViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    func setUpNavigationItems(items: [NaviagtionBarItems]) {
        var leftitems = [UIBarButtonItem]()
        var rightitems = [UIBarButtonItem]()
        //let navItem = UINavigationItem(title: "SomeTitle")
        items.forEach { item in
            switch item {
            case .logo:
                let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                negativeSpacer.width = 20
                leftitems.append(negativeSpacer)
                let buttonItem = UIBarButtonItem(customView: UIImageView(image: item.image))
                buttonItem.tintColor = .black
                leftitems.append(buttonItem)
            case .back:
                navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(customView: UIImageView(image: item.image))
                navigationBar.tintColor = .black
                navigationBar.backItem?.title = ""
            case .bell:
                let vc = UIImageView(image: item.image)
                let g = UITapGestureRecognizer(target: self, action: #selector(tappedBell(_:)))
                vc.addGestureRecognizer(g)
                vc.isUserInteractionEnabled = true
                
                let buttonItem = UIBarButtonItem(customView: vc)

                rightitems.append(buttonItem)
            case .add:
                let vc = UIImageView(image: UIImage(systemName: "plus.circle"))
                let g = UITapGestureRecognizer(target: self, action: #selector(tappedAdd(_:)))
                vc.addGestureRecognizer(g)
                vc.isUserInteractionEnabled = true
                
                let addButtonItem = UIBarButtonItem(customView: vc)
                rightitems.append(addButtonItem)
                
            case .setting:
                let buttonItem = UIBarButtonItem(customView: UIImageView(image: item.image))
                rightitems.append(buttonItem)
            case .delete:
                let buttonItem = UIBarButtonItem(customView: UIImageView(image: item.image))
                rightitems.append(buttonItem)
            }
        }
        let height = self.view.safeAreaInsets.top
        
        var tabFrame = self.navigationBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = height
        
        navigationBar.frame = tabFrame
        navigationBar.setNeedsLayout()
        navigationBar.layoutIfNeeded()
        navigationBar.frame = navigationBar.frame
        navigationBar.backgroundColor = .white
        
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 20)
        navigationBar.layer.shadowOpacity = 0.3
        navigationBar.layer.shadowRadius = 10
        navigationBar.topItem?.rightBarButtonItems = rightitems
        navigationBar.topItem?.leftBarButtonItems = leftitems
        navigationBar.tintColor = .black
        
        view.addSubview(navigationBar)
        view.bringSubviewToFront(navigationBar)
    }
}
