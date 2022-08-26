//
//  RankThemeTableViewCell.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/16.
//

import Foundation
import SnapKit
import UIKit

class ProvinceMeetTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let checkBox: UIButton = {
        let button = UIButton()
        button.isSelected = false
        button.backgroundColor = .white
        button.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        button.setImage(UIImage(), for: .normal)
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7.22, leading: 4.82, bottom: 6.8, trailing: 4.73)
        
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setAttributes()
        
        checkBox.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setAttributes()
    }

    
    func setUpCell() {
        
        [nameLabel, checkBox].forEach({
            contentView.addSubview($0)
        })
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
       
        nameLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        checkBox.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(checkBox.snp.height)
        }
        
       
    }
    
    func setAttributes() {
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        checkBox.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        checkBox.layer.borderWidth = 1.0
        checkBox.layer.cornerRadius = 4.0
    }
    
    @objc private func didTapButton(sender: UIButton){
        if sender.isSelected == false {
            sender.backgroundColor = UIColor.primaryColor
            sender.layer.borderColor = UIColor.primaryColor.cgColor
            sender.setImage(UIImage(named: "checkbox_checkImage"), for: .normal)
            sender.isSelected = true
        } else {
            sender.backgroundColor = .white
            sender.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
            sender.setImage(UIImage(), for: UIControl.State.normal)
            sender.isSelected = false
        }

    }
}

