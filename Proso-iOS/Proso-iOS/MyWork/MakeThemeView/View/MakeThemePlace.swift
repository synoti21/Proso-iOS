//
//  MakeThemeViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/06.
//

import Foundation
import UIKit
import SnapKit

class MakeThemeFifthViewController: UIViewController, UITextFieldDelegate, MTMapViewDelegate{
        
    var mapview: MTMapView!
    var createdTheme: ThemeCreateModel?

    
// MARK: - 구성 요소 추가
    
    let progressBar: UIProgressView = { ///진행 뷰
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        progressView.progress = 0.83
        return progressView
    }()
    
    let themeQustion: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "테마에 장소를 추가해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
   
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "장소 목록"
        label.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    let addLocationButton: UIButton = {
        let button = UIButton()
        let buttonIcon = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate)
        
        button.setTitle(" 장소 추가하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
        button.tintColor = #colorLiteral(red: 0.6642269492, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.6642269492,
                                           green: 0.6642268896,
                                           blue: 0.6642268896,
                                           alpha: 1), for: .normal)
        button.configuration?.titlePadding = 9.0
        button.layer.cornerRadius = 8.0
        button.setImage(buttonIcon, for: .normal)
        
        return button
    }()
    
    let nextButton: UIButton = { ///다음 버튼
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        button.isEnabled = true
        
        return button
    }()
    
// MARK: - 뷰 로드 시 작동 + 실시간 입력 글자 수
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        addView()
        setAtrributes()
        
        


        view.backgroundColor = .white
    }
    
// MARK: - AUTO LAYOUT 설정
    private func setAtrributes(){
        progressBar.snp.makeConstraints{
            $0.top.equalToSuperview().offset(88)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(4)
        }
        
        themeQustion.snp.makeConstraints{
            $0.top.equalTo(progressBar).offset(36)
            $0.leading.equalToSuperview().offset(20)
        }
        
        locationLabel.snp.makeConstraints{
            $0.top.equalTo(themeQustion.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addLocationButton.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
        nextButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(56)
        }
 
        nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) ///다음 버튼 활성화/비활성화를 위한 설정
        addLocationButton.addTarget(self, action: #selector(addLocation), for: .touchUpInside) ///다음 버튼 활성화/비활성화를 위한 설정

    }
    
// MARK: - 컴포넌트 추가 및 상단 네비게이션 바 설정
    private func addView(){
        [progressBar,themeQustion,locationLabel,addLocationButton,nextButton].forEach({
            self.view.addSubview($0)
        })
    }
    
    private func setUpNavigationBar() {
        title = "테마 만들기"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?
                                        .withTintColor(.black, renderingMode: .alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem = backButton
        
        ///그림자 추가하려고 하면 자꾸 글자 쪽에 추가되는 바람에 일단 보류.
    }
    
    @objc func dismissSelf(){
        self.navigationController?.popViewController(animated: true)
    }///뒤로 가기 버튼
    
    @objc private func addLocation(){ /// ** Map View 오류 관계로 임시로 완료 화면으로 넘어감 . 추후에 작업 예정**
        
        ///TextField의 Text를 불러와 서버에 넣는 함수. 또는 다음 뷰 컨트롤러에 데이터를 전달
        
        let rootVC = AddNewPlaceViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

// MARK: - 다음으로 이동
    @objc private func didTapButton(){
        
        ///TextField의 Text를 불러와 서버에 넣는 함수. 또는 다음 뷰 컨트롤러에 데이터를 전달
        
        let service = ThemeCreateService()
        guard let theme = createdTheme else {return}
        service.uploadTheme(theme){
            service.uploadImageFile(theme.themeImage)
            let rootVC = MakeThemeCompleteViewController()
            self.navigationController?.pushViewController(rootVC, animated: true)
        }

    }
    
}
