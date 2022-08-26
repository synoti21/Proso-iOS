//
//  ProvinceMeetCompletedViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/17.
//

import UIKit
import SnapKit
import Foundation

class ProvinceMeetCompletedViewController: UIViewController {
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인화면으로 돌아가기", for: .normal)
        button.backgroundColor = UIColor.primaryColor
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        return button
    }()
    
    let completeLabel: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "즉흥약속 보내기가\n완료되었어요."
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.2
        
        ///행 간 간격을 설정하기 위한 코드, 질문이 두줄 이므로 추가 설정
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center

        return label
    }()
    
    let completeLabelExtra: UILabel = {
        let label = UILabel()
        label.text = "친구가 수락할 때 까지 기다려볼까요?"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        
        return label
    }()
    
    let completeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThemeMakeComplete")
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        addView()
        setAttrbutes()
        
        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
   
    private func addView(){
        [sendButton,completeImage,completeLabel, completeLabelExtra].forEach({
            self.view.addSubview($0)
        })
    }
    
    private func setAttrbutes(){
        completeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(124)
            $0.centerX.equalToSuperview()
        }
        
        completeLabelExtra.snp.makeConstraints{
            $0.top.equalTo(completeLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        completeImage.snp.makeConstraints{
            $0.top.equalTo(completeLabelExtra.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview()
        }
        completeImage.heightAnchor.constraint(equalTo: completeImage.widthAnchor, multiplier: 340/375).isActive = true
        
        sendButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(34)
        }
        
        sendButton.heightAnchor.constraint(equalTo: sendButton.widthAnchor, multiplier: 56/335).isActive = true
    }
    
    private func setUpNavigationBar() {
        
        title = "즉흥약속 잡기"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?
            .withTintColor(.black, renderingMode: .alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissSelf))
        navigationItem.backBarButtonItem = backButton
       
        view.backgroundColor = .white
        
        ///그림자 추가하려고 하면 자꾸 글자 쪽에 추가되는 바람에 일단 보류.
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }

}
