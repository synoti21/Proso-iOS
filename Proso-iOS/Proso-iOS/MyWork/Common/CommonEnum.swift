//
//  CommonEnum.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/08.
//

enum NaviagtionBarItems {
    case logo
    case back
    case bell
    case add
    case setting
    case delete
    
    var image: UIImage {
        switch self {
        case .logo:
            return UIImage(named: "image_navigationbar logo re") ?? UIImage()
        case .back:
            return UIImage(systemName: "back_button_image") ?? UIImage()
        case .bell:
            return UIImage(systemName: "bell") ?? UIImage()
        case .add:
            return UIImage(systemName: "plus.circle") ?? UIImage()
        case .setting:
            return UIImage(named: "icon_setting") ?? UIImage()
        case .delete:
            return UIImage(systemName: "trash") ?? UIImage()
        }
    }
}

enum randomButton: CaseIterable {
    case random
    case meal
    case cafe
    
    var image: UIImage {
        switch self {
        case .cafe:
            return UIImage(named: "image_cafe") ?? UIImage()
        case .meal:
            return UIImage(named: "image_ restaurant") ?? UIImage()
        case .random:
            return UIImage(named: "image_random") ?? UIImage()
        }
        
    }
    
    var title: String {
        switch self {
        case .cafe:
            return "카페로 갈까요?"
        case .meal:
            return "식당으로 갈까요?"
        case .random:
            return "어디든로든 갈까요?"
        }
    }
}

enum TabItem: String, CaseIterable {
    case home = "홈"
    case theme = "테마추천"
    case myPage = "마이페이지"
    
    var viewController: UIViewController {
        switch self {
        case .home:
            return MainViewController()
        case .theme:
            return ThemeSuggestionMainViewController()
        case .myPage:
            return UIViewController()
            
        }
    }
    // these can be your icons
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .theme:
            return UIImage(systemName: "star")!
        case .myPage:
            return UIImage(systemName: "person")!
        }
    }
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house")!
        case .theme:
            return UIImage(systemName: "star.fill")!
        case .myPage:
            return UIImage(systemName: "person")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}

