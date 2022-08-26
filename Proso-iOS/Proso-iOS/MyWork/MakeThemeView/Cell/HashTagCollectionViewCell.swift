//
//  HashTagCollectionViewCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/09.
//

import Foundation
import SnapKit
import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

// MARK: - 음식 해쉬태그 셀, 카페 해쉬태그 셀, 액티비티 셀 설정
final class FoodCell: UICollectionViewCell {
    let foodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)

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
        contentView.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        contentView.layer.borderWidth = CGFloat(1.0)
        contentView.addSubview(foodLabel)

        foodLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    func setup(with hashTag: MakeThemeDefaultHashTag) { ///컬렉션 뷰에서 셀들을 불러올 때, 각 해쉬태그 카테고리별로 분류하여 셀들의 텍스트를 설정
        foodLabel.text = hashTag.context
    }
    
}

extension FoodCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

final class CafeCell: UICollectionViewCell {
    let cafeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12.0
        contentView.layer.cornerCurve = .continuous
        contentView.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        contentView.layer.borderWidth = CGFloat(1.0)
        contentView.addSubview(cafeLabel)

        cafeLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    func setup(with hashTag: MakeThemeDefaultHashTag) {
        cafeLabel.text = hashTag.context
    }
    

}

extension CafeCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

final class ActivityCell: UICollectionViewCell {
    let activityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12.0
        contentView.layer.cornerCurve = .continuous
        contentView.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        contentView.layer.borderWidth = CGFloat(1.0)
        contentView.addSubview(activityLabel)

        activityLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
    }
    func setup(with hashTag: MakeThemeDefaultHashTag) {
        activityLabel.text = hashTag.context
    }
    

}

extension ActivityCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

