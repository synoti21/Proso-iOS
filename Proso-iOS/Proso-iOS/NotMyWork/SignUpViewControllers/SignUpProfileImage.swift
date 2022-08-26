//
//  SignUpProfileImage.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/07.
//

import UIKit

class SignUpProfileImageViewController: UIViewController {
    
    let guideLineLabel: UILabel = {
        let label = UILabel()
        
        label.text = "프로필 사진을 설정해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18)
    
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
        imageView.image = UIImage(named: "placeHolderImage")
        
        return imageView
    }()
    
    let changeProfileImageButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("사진 변경하기", for: .normal)
        button.layer.borderColor = UIColor.primaryColor.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 3.0/10.0).isActive = true
        button.setTitleColor(.primaryColor, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    var finishButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryColor
        button.setTitle("가입 완료", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        self.navigationController?.setUpNavigationItems(items: [.back])
        layout()
        attributes()
    }
    
    private func layout() {
        [guideLineLabel, profileImageView, changeProfileImageButton, finishButton].forEach {
            view.addSubview($0)
        }
        
        guideLineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(128)
            $0.leading.equalToSuperview().inset(20)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(202)
            $0.leading.trailing.equalToSuperview().inset(90)
        }
        
        changeProfileImageButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(137)
        }
        
        finishButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
    }
    
    private func attributes() {
        changeProfileImageButton.addTarget(self, action: #selector(actionSheetAlert(_:)), for: .touchUpInside)
        
        finishButton.addTarget(self, action: #selector(tapFinishButton(_:)), for: .touchUpInside)
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
    
    @objc private func actionSheetAlert(_ sender: Any){
        let alert = UIAlertController(title: "선택", message: "선택", preferredStyle: .actionSheet)
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
    
    @objc private func tapFinishButton(_ sender: Any){
        if finishButton.backgroundColor == .primaryColor {
            let temp = TabBarViewController()
            temp.modalPresentationStyle = .fullScreen
            self.navigationController?.topViewController?.present(temp, animated: false)
        }
    }
}


extension SignUpProfileImageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
