
import UIKit
import SnapKit

class SignUpNickNameViewController: UIViewController {
    let guideLineLabel: UILabel = {
        let label = UILabel()
        
        label.text = "닉네임을 입력해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }()
    
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "내용 입력"
        
        return textField
    }()
    
    let underLineTextField: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.00)
        
        return view
    }()
    
    var nickNameCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "0/10"
        label.textColor = UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    var finishButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.87)
        button.setTitle("다음", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        self.navigationController?.setUpNavigationItems(items: [.back])
        attributes()
        layout()
    }
    
    private func attributes() {
        nickNameTextField.delegate = self
        nickNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        finishButton.backgroundColor = .primaryColor
        finishButton.addTarget(self, action: #selector(tapFinishButton(_:)), for: .touchUpInside)
    }
    
    private func layout() {
        [guideLineLabel, nickNameTextField, underLineTextField, nickNameCountLabel, finishButton].forEach {
            view.addSubview($0)
        }
        
        guideLineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(128)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(guideLineLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        underLineTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(3)
            $0.height.equalTo(1)
            $0.width.equalTo(nickNameTextField)
            $0.leading.equalTo(nickNameTextField)
        }
    
        nickNameCountLabel.snp.makeConstraints {
            $0.top.equalTo(underLineTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(underLineTextField.snp.trailing)
        }
        
        finishButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
    }
    
    @objc private func textFieldDidChange(_ sender: Any) {
        nickNameCountLabel.text = "\(nickNameTextField.text?.count ?? 0)/10"
    }
    
    @objc private func tapFinishButton(_ sender: Any){
        if finishButton.backgroundColor == .primaryColor {
            let nextVC = SignUpProfileImageViewController()
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
}

extension SignUpNickNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let characterCountLimit = 10
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace = range.length

        let newLength = startingLength + lengthToAdd - lengthToReplace

        return newLength <= characterCountLimit
    }
}
