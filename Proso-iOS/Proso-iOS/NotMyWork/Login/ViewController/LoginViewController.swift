
import UIKit
import SnapKit
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    let subTitle = "이제야 보이세요?"
    let mainPreFixTitle = "P로소"
    let mainPostFixTitle = "보이는 것들"
    
    let subTitleLabel = UILabel()
    let mainPrefixTitleLabel = UILabel()
    let mainPostFixTitleLabel = UILabel()
    let underHighlighter = UIView()
    let kakaoLoginButton = UIImageView()
    let appleLoginButton = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attributes()
        layout()
    }
    
    private func attributes() {
        subTitleLabel.text = subTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: 24)
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .black
        
        mainPrefixTitleLabel.text = mainPreFixTitle
        mainPrefixTitleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        mainPrefixTitleLabel.textAlignment = .center
        mainPrefixTitleLabel.textColor = .black
        
        underHighlighter.backgroundColor = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
        
        mainPostFixTitleLabel.text = mainPostFixTitle
        mainPostFixTitleLabel.font = UIFont.systemFont(ofSize: 32)
        mainPostFixTitleLabel.textColor = .black
        
        kakaoLoginButton.image = UIImage(named: "KakaoLoginButton")
        kakaoLoginButton.contentMode = .scaleToFill
        let tapKaKaoLoginButton = UITapGestureRecognizer(target: self, action: #selector(tapKakaoLoginButtion(_:)))
        kakaoLoginButton.addGestureRecognizer(tapKaKaoLoginButton)
        kakaoLoginButton.isUserInteractionEnabled = true
        kakaoLoginButton.heightAnchor.constraint(equalTo: kakaoLoginButton.widthAnchor, multiplier: 56.0/335.0).isActive = true
        kakaoLoginButton.contentMode = .scaleToFill
        
        appleLoginButton.heightAnchor.constraint(equalTo: appleLoginButton.widthAnchor, multiplier: 56.0/335.0).isActive = true
        appleLoginButton.image = UIImage(named: "login_apple")
    }
    
    private func layout() {
        [subTitleLabel, underHighlighter, mainPrefixTitleLabel, mainPostFixTitleLabel, kakaoLoginButton, appleLoginButton].forEach {
            view.addSubview($0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(124)
            $0.height.equalTo((view.frame.width - 203) * 0.2)
        }
        
        mainPrefixTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(67)
        }
        
        underHighlighter.snp.makeConstraints {
            $0.centerX.equalTo(mainPrefixTitleLabel.snp.centerX)
            $0.width.equalTo(mainPrefixTitleLabel.snp.width)
            $0.height.equalTo(14)
            $0.centerY.equalTo(mainPrefixTitleLabel.snp.centerY).offset(15)
        }
        
        mainPostFixTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(mainPrefixTitleLabel.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(67)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(90)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc private func tapKakaoLoginButtion(_ sender: UITapGestureRecognizer) {
        LoginService.shared.kakaoLogin() {
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
        
}
