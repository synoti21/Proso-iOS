//
//  MakeThemeViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/06.
//

import Foundation
import UIKit
import SnapKit

class MakeThemeFirstViewController: UIViewController, MTMapViewDelegate{
        
    var mapview: MTMapView!
    var createdTheme = ThemeCreateModel()
    
// MARK: - 구성 요소 추가
    var textCount = 0 ///입력 칸 글자 수 카운트
    
    let progressBar: UIProgressView = { ///진행 뷰
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        progressView.progress = 0.165
        return progressView
    }()
    
    let themeQustion: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "테마 이름을 입력해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
    
    let inputField: UITextField = { ///사용자 입력 칸, 디자인이 밑줄 형태이므로 frame 커스텀화
        let textField = UITextField()
        
        textField.placeholder = "내용 입력"
        textField.font = UIFont.boldSystemFont(ofSize: 14.0)
        textField.adjustsFontSizeToFitWidth = true

        return textField
    }()
    
    let inputFieldUnderLine: UIView = {
        let textFieldLine = UIView()
        textFieldLine.backgroundColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        
        return textFieldLine
    }()
    
    let textCountLabel: UILabel = { ///입력 글자 수 표시 (입력칸 아래에)
        let label = UILabel()
        label.text = "0/0"
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textColor = #colorLiteral(red: 0.4756370187, green: 0.4756369591, blue: 0.4756369591, alpha: 1)
        
        return label
    }()
    
    let nextButton: UIButton = { ///다음 버튼
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        button.isEnabled = false
        
        return button
    }()
    
// MARK: - 뷰 로드 시 작동 + 실시간 입력 글자 수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "테마 만들기"
        setUpNavigationBar()


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setAtrributes()
        hideKeyboardWhenTap()
        
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
        
        inputField.snp.makeConstraints{
            $0.top.equalTo(themeQustion.snp.bottom).offset(24)
            $0.height.equalTo(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        inputFieldUnderLine.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(inputField.snp.bottom).offset(8)
        }
        
        nextButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(56)
        }
        
        textCountLabel.snp.makeConstraints{
            $0.top.equalTo(inputFieldUnderLine.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        inputField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged) ///글자 수 카운트를 위한 설정
        
        nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) ///다음 버튼 활성화/비활성화를 위한 설정
    }
    
// MARK: - 컴포넌트 추가 및 상단 네비게이션 바 설정
    private func addView(){
        [progressBar,themeQustion,inputField,inputFieldUnderLine,textCountLabel,nextButton].forEach({
            self.view.addSubview($0)
        })
        inputField.delegate = self ///입력 칸 글자 수 카운트를 위한 delegate 설정
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
        dismiss(animated: true)
    }
    
// MARK: - 입력 칸 글자 수 제한
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 30
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
// MARK: - 실시간 글자 수 계산
    @objc func textFieldDidChange(textField : UITextField){
        textCount = inputField.text!.count
        textCountLabel.text = "\(String(describing: textCount))/30"
        if(textCount > 0){
            nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
            nextButton.isEnabled = true
        }else{
            nextButton.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
            nextButton.isEnabled = false
        }
    }
    
// MARK: - 다음으로 이동
    @objc private func didTapButton(){
        
        ///TextField의 Text를 불러와 서버에 넣는 함수. 또는 다음 뷰 컨트롤러에 데이터를 전달
        
        let rootVC = MakeThemeSecondViewController()
        createdTheme.themeTitle = inputField.text!
        rootVC.createdTheme = createdTheme
        self.navigationController?.pushViewController(rootVC, animated: false)
       
    }
}

extension MakeThemeFirstViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.view.endEditing(true)
      return false
  }
}
