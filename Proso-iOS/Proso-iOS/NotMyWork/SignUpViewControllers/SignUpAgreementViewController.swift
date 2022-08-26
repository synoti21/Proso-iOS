
import UIKit

class SignUpAgreementViewController: UIViewController {
    let guideLineLabel: UILabel = {
        let label = UILabel()
        
        label.text = "약관에 동의해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    var agreementTableView = UITableView(frame: .zero, style: .plain)
    
    var agreementTextList = ["전체동의", "14세 이상입니다.", "이용약관 동의", "개인정보처리방침 동의"]
    
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
        self.navigationController?.setUpNavigationItems(items: [.back, .bell])
        layout()
        attributes()
    }
    
    private func layout() {
        [guideLineLabel, finishButton, agreementTableView].forEach {
            view.addSubview($0)
        }
        
        guideLineLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(128)
            $0.leading.equalToSuperview().inset(20)
        }
        
        finishButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
        
        agreementTableView.snp.makeConstraints {
            $0.top.equalTo(guideLineLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(finishButton.snp.top).offset(-20)
        }
        
    }
    
    private func attributes() {
        agreementTableView.dataSource = self
        agreementTableView.delegate = self
        agreementTableView.register(AgreementTableViewCell.self, forCellReuseIdentifier: "AgreementTableViewCell")
        agreementTableView.isScrollEnabled = false
        agreementTableView.separatorStyle = .none
        agreementTableView.sectionIndexColor = .none
        agreementTableView.backgroundColor = .white
        
        finishButton.addTarget(self, action: #selector(tapFinishButton(_:)), for: .touchUpInside)
    }
    
    @objc private func tapFinishButton(_ sender: Any){
        if finishButton.backgroundColor == .primaryColor {
            let nextVC = SignUpNickNameViewController()
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
    }
}

extension SignUpAgreementViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AgreementTableViewCell") as? AgreementTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.agreementLabel.text = agreementTextList[indexPath.row]
        cell.agreementLabel.textColor = .black
        cell.backgroundColor = .white
        
        if indexPath.row == 0 {
            cell.isFirst = true
        }
        return cell
    }
    
}

extension SignUpAgreementViewController: tapFirstAgreementButton {
    func tapAnotherButton() {
        let firstCell = agreementTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AgreementTableViewCell
        var check = true
        for i in 1 ..< agreementTableView.numberOfRows(inSection: 0) {
            let cell = agreementTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AgreementTableViewCell
            if !(cell?.checkBox.isSelected ?? false) {
                check = false
            }
        }
        firstCell?.checkBox.isSelected = check
        if check {
            finishButton.backgroundColor = .primaryColor
        }
        else {
            finishButton.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.87)
        }
    }
    
    func tapFirstButtion(_ all: Bool) {
        for i in 0 ..< agreementTableView.numberOfRows(inSection: 0) {
            let cell = agreementTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? AgreementTableViewCell
            cell?.checkBox.isSelected = all
        }
        if all {
            finishButton.backgroundColor = .primaryColor
        }
        
        else {
            finishButton.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 0.87)
        }
    }
}

protocol tapFirstAgreementButton {
    func tapAnotherButton()
    func tapFirstButtion(_ all: Bool)
}

class AgreementTableViewCell: UITableViewCell {
    
    var delegate: tapFirstAgreementButton? = nil
    var agreementString: String?
    var isFirst: Bool = false
    var shouldUnderLine: Bool?
    let agreementLabel = UILabel()
    var checkBox = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        attributes()
    }
    
    private func layout() {
        [agreementLabel, checkBox].forEach {
            self.addSubview($0)
        }
        agreementLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        checkBox.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    private func attributes() {
        checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        checkBox.tintColor = .primaryColor
        checkBox.addTarget(self, action: #selector(toggleCheckBox(_:)), for: .touchUpInside)
        checkBox.isUserInteractionEnabled = true
        
        agreementLabel.font = UIFont.systemFont(ofSize: 14)
        if shouldUnderLine ?? false {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
            agreementLabel.attributedText = underlineAttributedString
        }
    }
    
    @objc private func toggleCheckBox(_ sender: Any) {
        checkBox.isSelected.toggle()
        if isFirst {
            delegate?.tapFirstButtion(checkBox.isSelected)
        }
        else {
            delegate?.tapAnotherButton()
        }
    }
}

