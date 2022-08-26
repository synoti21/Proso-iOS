//
//  MakeThemeCompleteViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/10.
//

import UIKit
import SnapKit
import Foundation

class MakeThemeCompleteViewController: UIViewController {
    
    var createdTheme: ThemeCreateModel?
    
    let progressBar: UIProgressView = { ///진행 뷰
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        progressView.progress = 1.0
        return progressView
    }()
    
    let completeLabel: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "테마 작성이\n완료되었어요!"
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
    
    let completeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThemeMakeComplete")
        
        return imageView
    }()
    
    let menuButton: UIButton = { ///다음 버튼
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitle("메인화면으로 돌아가기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        button.isEnabled = false
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        addView()
        setAtrributes()
    }
    
    private func setUpNavigationBar() {
        title = "테마 만들기"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?
                                        .withTintColor(.black, renderingMode: .alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = .white
        ///그림자 추가하려고 하면 자꾸 글자 쪽에 추가되는 바람에 일단 보류.
    }
    
    
    private func setAtrributes(){
        let imageRatio = 0.906
        progressBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(88)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(4)
        }
      
        
        completeLabel.snp.makeConstraints{
            $0.top.equalTo(progressBar.snp.bottom).offset(76)
            $0.centerX.equalToSuperview()
        }
        
        completeImage.snp.makeConstraints{
            $0.top.equalTo(completeLabel.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(completeImage.snp.width).multipliedBy(imageRatio)
        }
        
        menuButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(56)
        }
 
        menuButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) ///다음 버튼 활성화/비활성화를 위한 설정

    }
    
    private func addView(){
        [progressBar,completeLabel,completeImage,menuButton].forEach({
            self.view.addSubview($0)
        })
    }
 
    @objc func dismissSelf(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapButton(){
        
        ///TextField의 Text를 불러와 서버에 넣는 함수. 또는 다음 뷰 컨트롤러에 데이터를 전달
        
        dismiss(animated: true, completion: nil)



    }


}
