//
//  RisingThemeTableViewCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/18.
//

import UIKit
import SnapKit
import Kingfisher

class RisingThemeTableViewCell: UITableViewCell {
    
    var themeId = Int()
    var themeLabel = UILabel()

    var userInfoView = UIView()
    var userProfileImage = UIImageView()
    
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    
    
    let cellCategory: UITextView = {
        let textView = UITextView()
        //textView.text = category
        textView.font = UIFont.systemFont(ofSize: 12.0)
        textView.textColor = .white
        textView.backgroundColor = #colorLiteral(red: 1, green: 0.822599709, blue: 0.4534067512, alpha: 1)
        textView.layer.cornerRadius = 4.0
        textView.textAlignment = .center
        textView.isEditable = false
        
        return textView
    }()
    
    
    //let cellCategoryViewSize = cellCategory.text.size(withAttributes: [NSAttributedString.Key.font: cellCategory.font ?? UIFont()])
    
    //cellCategory.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    
    
    let cellTitle: UILabel = {
        let label = UILabel()
        //label.text = title
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        return label
    }()
    
    let heartCount: UILabel = {
        let label = UILabel()
        label.text = "52"
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        
        return label
    }()
    
    let cellView = UIView()
    
    var cellCategoryViewSize = CGSize()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUserInfoView()
        setView()
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0))
        
    }
    
    func setView(){
         
        cellView.backgroundColor = .white
        cellView.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        cellView.layer.borderWidth = 1.0
        cellView.layer.cornerRadius = 8.0
        cellView.layer.masksToBounds = true
        
        cellCategory.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        
        
        [cellImage, cellCategory,cellTitle].forEach({
            cellView.addSubview($0)
        })
        
        [cellView, userInfoView].forEach({
            contentView.addSubview($0)
        })
        /*cellHashTag.forEach({
            mainView.inser($0)
        })*/
        
        // MARK: - constraint
        userInfoView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        userInfoView.heightAnchor.constraint(equalTo: userInfoView.widthAnchor, multiplier: 42/335).isActive = true
        
        cellView.snp.makeConstraints{
            $0.top.equalTo(userInfoView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        cellImage.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        cellImage.heightAnchor.constraint(equalTo: cellImage.widthAnchor, multiplier: 120/335).isActive = true
        
        cellCategory.snp.makeConstraints{
            $0.top.equalTo(cellImage.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(12)
        }
        
        cellTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.top.equalTo(cellCategory.snp.bottom).offset(4)
        }
    }
    
    func setup(with theme: ThemeRisingModel){
        guard let imageURL = URL.init(string: APIConstants.baseURL + "/" + theme.data.themeImgURL) else { return }
        
        print(imageURL)
        themeId = theme.data.themeID
        cellImage.load(url: imageURL)
        cellCategory.text = "카페 / 음식점"
        themeLabel.text = theme.data.userName + "님의 테마"
        
        cellTitle.text = theme.data.themeTitle
        cellCategoryViewSize = cellCategory.text.size(withAttributes: [NSAttributedString.Key.font: cellCategory.font ?? UIFont()])
        
        
        cellCategory.snp.makeConstraints{
            $0.width.equalTo(cellCategoryViewSize.width+20)
            $0.height.equalTo(cellCategoryViewSize.height+8)
        }
    }
    
    func setBookmarkCount(with theme: ThemeInfoModel){
        heartCount.text = String(theme.bookmarkCount)
    }
    
    func setUserInfoView(){
        
        let profileImage = userProfileImage
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
        profileImage.layer.cornerRadius = 22.5
        
        themeLabel.font = .systemFont(ofSize: 14.0)
              
        let heart = UIImageView()
        heart.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        heart.tintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        
        let heartCount = UILabel()
        heartCount.text = "52"
        heartCount.font = UIFont.systemFont(ofSize: 12.0)
        heartCount.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        
        
        let moreInfo = UIImageView()
        
        moreInfo.image = UIImage(named: "moreInfo_arrow")?.withRenderingMode(.alwaysTemplate)
        moreInfo.tintColor = #colorLiteral(red: 0.08947802335, green: 0.08947802335, blue: 0.08947802335, alpha: 1)
        
        [profileImage,themeLabel,heart,heartCount,moreInfo].forEach({
            userInfoView.addSubview($0)
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
        
        moreInfo.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(7.28)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(16.22/42)
        }
        moreInfo.widthAnchor.constraint(equalTo: moreInfo.heightAnchor, multiplier: 9.47/16.22).isActive = true
    }

    
    
   

}



