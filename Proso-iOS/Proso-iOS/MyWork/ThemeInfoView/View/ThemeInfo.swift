//
//  ThemeInfoViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/17.
//

import UIKit
import SnapKit
import Foundation

class ThemeInfoViewController: UIViewController {
  
    let themeInfoService = ThemeInfoService()
    
    var themeInfoId: Int?
    var mainThemeModel: ThemeInfoModel?
    
    let themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    let themeUserInfoView = UIView()
    
    let themeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        return label
    }()
    
    let themeIntroduction: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        
        return label
    }()
    
    let themeSeperator: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.9436392188, green: 0.9436392188, blue: 0.9436392188, alpha: 1)
        
        return line
    }()
    
    let recommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("추천받기", for: .normal)
        button.setTitleColor(UIColor.primaryColor, for: .normal)
        button.layer.borderColor = UIColor.primaryColor.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return button
    }()
    
    let provinceMeetButton: UIButton = {
        let button = UIButton()
        button.setTitle("즉흥약속 잡기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.primaryColor.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.backgroundColor = UIColor.primaryColor
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        loadThemeInfo()
        setUserInfoView()
        addView()
        setAttributes()
        
        provinceMeetButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
    }
    
    private func loadThemeInfo(){
        if let themeId = themeInfoId{
            themeInfoService.getThemeArray(themeId){(theme: ThemeInfoModel) in
                self.mainThemeModel = theme
            }
        }else{
            return
        }
        
        guard let imageURL = URL.init(string: mainThemeModel?.themeImgURL ?? String()) else {return}
        themeImageView.load(url: imageURL)
        themeTitle.text = mainThemeModel?.themeTitle
        themeIntroduction.text = mainThemeModel?.themeIntroduce
    }
    

    private func setUserInfoView(){
        let risingTheme = mainThemeModel
        
        let profileImage = UIImageView()
        let image = UIImage(named: "defaultProfile")
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = image
        profileImage.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
        profileImage.layer.cornerRadius = 22.5
        
        
        let themeLabel = UILabel()
        guard let username = risingTheme?.userName else { return }
        let att = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let boldedUsername = NSMutableAttributedString(string: username, attributes: att).string
        themeLabel.text = boldedUsername + "님의 테마"
        themeLabel.font = .systemFont(ofSize: 14.0)
        
        let heart = UIImageView()
        heart.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        heart.tintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        
        let heartCount = UILabel()
        heartCount.text = "52"
        heartCount.font = UIFont.systemFont(ofSize: 12.0)
        heartCount.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        
        
       
        
        [profileImage,themeLabel,heart,heartCount].forEach({
            themeUserInfoView.addSubview($0)
        })
        // MARK: - make Constraints
        
        profileImage.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(profileImage.snp.height)
        }
        
        themeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(3)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
        
        heart.snp.makeConstraints{
            $0.leading.equalTo(themeLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(2)
            $0.width.equalTo(16.15)
            $0.height.equalTo(13.98)///
        }
        
        heartCount.snp.makeConstraints{
            $0.leading.equalTo(heart.snp.trailing).offset(4.92)
            $0.bottom.equalToSuperview().inset(2)
            
        }
        
       
        
    }
    private func addView(){
        [themeImageView,themeUserInfoView, themeTitle, themeIntroduction, themeSeperator, recommendButton, provinceMeetButton].forEach({
            view.addSubview($0)
        })
    }
    private func setAttributes(){
        themeImageView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        themeImageView.heightAnchor.constraint(equalTo: themeImageView.widthAnchor, multiplier: 274/375).isActive = true
        
        
        themeUserInfoView.snp.makeConstraints{
            $0.top.equalTo(themeImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        themeUserInfoView.heightAnchor.constraint(equalTo: themeUserInfoView.widthAnchor, multiplier: 42/335).isActive = true
        
        
        themeTitle.snp.makeConstraints{
            $0.top.equalTo(themeUserInfoView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        themeIntroduction.snp.makeConstraints{
            $0.top.equalTo(themeTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            
        }
        
        themeSeperator.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(themeIntroduction.snp.bottom).offset(24)
            $0.height.equalTo(1.0)
        }
        
        
        recommendButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.equalToSuperview().inset(20)
        }
        
        recommendButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 162/375).isActive = true
        
        recommendButton.heightAnchor.constraint(equalTo: recommendButton.widthAnchor, multiplier: 56/162).isActive = true
        
        
        provinceMeetButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(34)
            $0.trailing.equalToSuperview().inset(20)
        }
        provinceMeetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 162/375).isActive = true
        provinceMeetButton.heightAnchor.constraint(equalTo: provinceMeetButton.widthAnchor, multiplier: 56/162).isActive = true
        
    }
    
    private func setUpNavigationBar() {
        
        title = "테마 정보"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?
            .withTintColor(.black, renderingMode: .alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem = backButton
       
        view.backgroundColor = .white
        
        ///그림자 추가하려고 하면 자꾸 글자 쪽에 추가되는 바람에 일단 보류.
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapButton(){
        
        ///TextField의 Text를 불러와 서버에 넣는 함수. 또는 다음 뷰 컨트롤러에 데이터를 전달
        
        let rootVC = ProvinceMeetViewController()
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
}
