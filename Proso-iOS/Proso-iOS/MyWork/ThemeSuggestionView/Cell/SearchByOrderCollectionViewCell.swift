//
//  SearchByOrderCollectionViewCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/17.
//

import UIKit

class SearchByOrderCollectionViewCell: UICollectionViewCell {
    
    let orderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){ ///해쉬태그 버튼 모양 설정
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12.0
        contentView.layer.cornerCurve = .continuous
        contentView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        contentView.layer.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        contentView.layer.borderWidth = CGFloat(1.0)
        contentView.addSubview(orderLabel)
        
        orderLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    func setup(with orderBy: String) { ///컬렉션 뷰에서 셀들을 불러올 때, 각 해쉬태그 카테고리별로 분류하여 셀들의 텍스트를 설정
        orderLabel.text = orderBy
    }
    
    
    
    
}
extension SearchByOrderCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
