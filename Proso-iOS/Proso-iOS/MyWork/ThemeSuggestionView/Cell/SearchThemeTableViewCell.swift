//
//  RisingThemeTableViewCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/18.
//

import UIKit
import SnapKit
import Kingfisher

class SearchThemeTableViewCell: UITableViewCell {
    
    var themeId = Int()
    
    
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
    
    var cellCategoryViewSize = CGSize()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
         
        contentView.backgroundColor = .white
        contentView.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        
        cellCategory.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        
        
        [cellImage, cellCategory,cellTitle].forEach({
            contentView.addSubview($0)
        })
        /*cellHashTag.forEach({
            mainView.inser($0)
        })*/
        
        // MARK: - constraint
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
    
    func setup(with theme: ThemeSearchModel){
        
        guard let imageURL = URL.init(string: theme.themeImgURL) else { return }
        
        themeId = theme.themeID
        cellImage.load(url: imageURL)
        cellCategory.text = "카페 / 음식점"
        cellTitle.text = theme.themeTitle
        cellCategoryViewSize = cellCategory.text.size(withAttributes: [NSAttributedString.Key.font: cellCategory.font ?? UIFont()])
        
        cellCategory.snp.makeConstraints{
            $0.width.equalTo(cellCategoryViewSize.width+20)
            $0.height.equalTo(cellCategoryViewSize.height+8)
        }
    }
    
    
    
   

}
