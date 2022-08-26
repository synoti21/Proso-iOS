//
//  ReviewTableCell.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/08.
//

import UIKit
import SnapKit

class ReviewTableViewCell: UITableViewCell {
    let starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        
        imageView.tintColor = UIColor(red: 1.00, green: 0.79, blue: 0.38, alpha: 1.00)
        
        return imageView
    }()
    let startPointLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .secondNaturalColor
        label.text = "4.8"
        
        return label
    }()
    let visitDayLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .thirdNaturalColor
        label.text = "2022. 03. 31. 방문"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    let contentTextlabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "처음 가본 카페였지만, 따스한 분귀기가 너무나도 마움에 들었다."
        label.textColor = .black

        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        attributes()
    }
    
    private func attributes() {
        backgroundColor = .white
        
    }
    
    private func layout(){
        [starImageView, startPointLabel, visitDayLabel, contentTextlabel].forEach {
            addSubview($0)
        }
        
        starImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.height.width.equalTo(16)
        }
        
        startPointLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(starImageView.snp.centerY)
        }
        
        visitDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView.snp.centerY)
            $0.leading.equalTo(startPointLabel.snp.trailing).offset(16)
        }
        
        contentTextlabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(starImageView.snp.bottom).offset(8)
        }
        
    }
}
