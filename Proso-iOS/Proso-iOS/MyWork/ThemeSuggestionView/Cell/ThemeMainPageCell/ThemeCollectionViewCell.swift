//
//  ThemeCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/14.
//

import Foundation
import SnapKit
import UIKit


class ThemeCollectionViewCell: UICollectionViewCell{
    var themeID = Int()
    
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    var isBookmarked = false
    
    
    
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
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
        var isBookmarked = false
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        return button
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
    
    /*let cellHashTag = [UITextView()]
    for index in 0..<hashtag.count{
        cellHashTag[index].text = hashtag[index]
        cellHashTag[index].font = UIFont.systemFont(ofSize: 12.0)
        cellHashTag[index].textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        cellHashTag[index].backgroundColor = #colorLiteral(red: 0.9436392188, green: 0.9436392188, blue: 0.9436392188, alpha: 1)
        cellHashTag[index].layer.cornerRadius = 14.0
        cellHashTag[index].textContainerInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
    }*/
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setView()
        bookmarkButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(_ sender: UIButton){
        if isBookmarked == false{
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            isBookmarked = true
        }else{
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            isBookmarked = false
        }
    }
    
    func setView(){
        contentView.backgroundColor = .white
        contentView.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        
        cellCategory.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        
        cellImage.addSubview(bookmarkButton)

        
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
        
        bookmarkButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(6)
            $0.width.equalTo(21)
            $0.height.equalTo(21)
        }
    }
    
    func setup(with theme: ThemeSuggestionDatum){
        
        guard let imageURL = URL.init(string: theme.themeImgURL) else { return }
        print("qwer")
        cellImage.load(url: imageURL)
        themeID = theme.themeID
        cellCategory.text = "카페 / 음식점"
        cellTitle.text = theme.themeTitle
        cellCategoryViewSize = cellCategory.text.size(withAttributes: [NSAttributedString.Key.font: cellCategory.font ?? UIFont()])
        
        cellCategory.snp.makeConstraints{
            $0.width.equalTo(cellCategoryViewSize.width+20)
            $0.height.equalTo(cellCategoryViewSize.height+8)
        }
    }
}

extension ThemeCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
