//
//  MakeThemeViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/06.
//

import Foundation
import UIKit
import SnapKit

class MakeThemeFourthViewController: UIViewController, MTMapViewDelegate{
        
    var mapview: MTMapView!
    var createdTheme: ThemeCreateModel?

    
// MARK: - 구성 요소 추가
    var textCount = 0 ///입력 칸 글자 수 카운트
    
    let progressBar: UIProgressView = { ///진행 뷰
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        progressView.progress = 0.66
        return progressView
    }()
    
    let themeQustion: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "테마 배경사진을 설정해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()

    let backGroundImage: UIImageView = { ///배경 사진 이미지 뷰
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default_background")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 8.0
        imageView.layer.cornerCurve = .continuous
        return imageView
    }()
    
    let changeBackGroundButton: UIButton = { ///사진 변경 버튼
        let button = UIButton()
        button.setTitle("사진 변경하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1,
                                           green: 0.3294117647,
                                           blue: 0.3294117647,
                                           alpha: 1),
                                           for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.layer.cornerCurve = .continuous

        
        return button
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
    
// MARK: - 뷰 로드 시 작동
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        addView()
        setAtrributes()

        changeBackGroundButton.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
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
        
        backGroundImage.snp.makeConstraints{
            $0.top.equalTo(themeQustion.snp.bottom).offset(72)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(120)
        }
        
        changeBackGroundButton.snp.makeConstraints{
            $0.top.equalTo(backGroundImage.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(29)
        }
        
        changeBackGroundButton.titleLabel?.snp.makeConstraints{
            $0.leading.trailing.equalTo(changeBackGroundButton).inset(16)

        }
      
        nextButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(56)
        }
        
        
        nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) ///다음 버튼 활성화/비활성화를 위한 설정
    }
    
// MARK: - 컴포넌트 추가 및 상단 네비게이션 바 설정
    private func addView(){
        [progressBar,themeQustion,backGroundImage,changeBackGroundButton,nextButton].forEach({
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
    
    // MARK: - 사진 업로드
    @objc func uploadPhoto(){
        let alert = UIAlertController(title: "배경사진 선택", message: "테마 배경사진 선택", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] (_) in
            self?.presentCamera()
        }
        let album = UIAlertAction(title: "앨범", style: .default) { [weak self] (_) in
            self?.presentAlbum()
        }
        
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(album)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.cameraFlashMode = .on
        
        present(vc, animated: true, completion: nil)
    }
    
    private func presentAlbum(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true, completion: nil)
    }
    
    
    
// MARK: - 다음으로 이동
    @objc private func didTapButton(){
        
        ///TextField의 Text를 불러와 서버에 넣는 함수. 또는 다음 뷰 컨트롤러에 데이터를 전달
        
        let rootVC = MakeThemeFifthViewController()
        createdTheme?.themeImage = backGroundImage.image ?? UIImage()
        rootVC.createdTheme = createdTheme
        self.navigationController?.pushViewController(rootVC, animated: false)
    }
}

// MARK: - 이미지 업로드를 위한 extension
extension MakeThemeFourthViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:
                               [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            backGroundImage.contentMode = .scaleAspectFill
            backGroundImage.image = pickedImage
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        }
        dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

