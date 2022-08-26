//
//  MakeThemeViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/06.
//

import Foundation
import UIKit
import SnapKit

class MakeThemeSecondViewController: UIViewController, UITextViewDelegate, MTMapViewDelegate{
        
    var mapview: MTMapView!
    var createdTheme: ThemeCreateModel?

    
// MARK: - 구성 요소 추가
    let progressBar: UIProgressView = { ///진행 뷰
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        progressView.progress = 0.33
        return progressView
    }()
    
    let themeQustion: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "테마 소개글을 입력해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
    
    let inputField: UITextView = { ///textfield는 여러 줄 처리가 불가능하므로 textView로 대체
        let textView = UITextView()
        
        textView.isEditable = true
        textView.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderWidth = CGFloat(1.0)
        textView.layer.cornerRadius = CGFloat(8.0)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12);

        
        return textView
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
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setAtrributes()
        setUpNavigationBar()
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
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        inputField.heightAnchor.constraint(equalTo: inputField.widthAnchor, multiplier: 105/335).isActive = true
        
        nextButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(56)
        }
        
        inputField.textColor = .lightGray
        inputField.text = "내용 입력"
    
        
        nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
// MARK: - 컴포넌트 추가 및 상단 네비게이션 바 설정
    private func addView(){
        [progressBar,themeQustion,inputField,nextButton].forEach({
            self.view.addSubview($0)
        })
        inputField.delegate = self ///입력 칸 글자 수 카운트
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
    }
    
// MARK: - 버튼 활성화/비활성화
    func textViewDidChange(_ textView: UITextView) {
        let textCount = inputField.text!.count
        if(textCount > 0){
            nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
            nextButton.isEnabled = true
        }else{
            nextButton.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
            nextButton.isEnabled = false
        }
    }
    
// MARK: - TextView Placeholder 설정
    func textViewDidBeginEditing (_ textView: UITextView) {
        if inputField.textColor == .lightGray && inputField.isFirstResponder {
            inputField.text = nil
            inputField.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if inputField.text.isEmpty || inputField.text == "" {
            inputField.textColor = .lightGray
            inputField.text = "내용 입력"
        }
    }
    
// MARK: - 다음으로 이동
    @objc private func didTapButton(){
        
        ///TextView의 Text를 불러와 서버에 넣는 코드. 또는 다음 뷰 컨트롤러에 정보 전달

        let rootVC = MakeThemeThirdViewController()
        createdTheme?.themeIntroduce = inputField.text
        rootVC.createdTheme = createdTheme
        self.navigationController?.pushViewController(rootVC, animated: false)
    }
}

extension UITextField {
    func setLeftPaddingPoints(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
