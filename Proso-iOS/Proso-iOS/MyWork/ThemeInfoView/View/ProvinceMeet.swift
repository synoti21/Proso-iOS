//
//  ProvinceMeetViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/17.
//

import UIKit
import SnapKit

class ProvinceMeetViewController: UIViewController {
    
    let friendListLabel: UILabel = {
        let label = UILabel()
        label.text = "친구목록"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18.0)
        
        return label
    }()
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색어를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14.0)
        textField.textColor = #colorLiteral(red: 0.797753036, green: 0.7977529764, blue: 0.7977529764, alpha: 1)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        textField.layer.cornerRadius = 8.0
        
        let searchIcon = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)


        let searchIconView = UIImageView(image: searchIcon)
        searchIconView.tintColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        textField.addSubview(searchIconView)
        
        searchIconView.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(9.8)
            $0.top.bottom.equalToSuperview().inset(9.8)
            $0.height.equalTo(searchIconView.snp.width)
        }
        return textField
    }()
    
    let friendCountLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 3명"
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = #colorLiteral(red: 0.6642269492, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
        
        return label
    }()
    
    let friendListTableView: UITableView = {
        let view = UITableView()
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.allowsSelection = false
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("약속 보내기", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setDelegate()
        addView()
        setAttributes()
        // Do any additional setup after loading the view.
    }
    
    private func addView(){
        [friendListLabel,searchField,friendCountLabel,friendListTableView,sendButton].forEach({
            self.view.addSubview($0)
        })
    }
    
    private func setAttributes(){
        friendListLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.leading.equalToSuperview().inset(20)
        }
        searchField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(friendListLabel.snp.bottom).offset(12)
        }
        searchField.heightAnchor.constraint(equalTo: searchField.widthAnchor, multiplier: 40/335).isActive = true
        
        friendCountLabel.snp.makeConstraints{
            $0.top.equalTo(searchField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        friendListTableView.snp.makeConstraints{
            $0.top.equalTo(friendCountLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(sendButton.snp.top)
        }
        sendButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        sendButton.heightAnchor.constraint(equalTo: sendButton.widthAnchor, multiplier: 56/335).isActive = true
        
    }
    
    private func setDelegate(){
        friendListTableView.dataSource = self
        friendListTableView.delegate = self
        friendListTableView.register(ProvinceMeetTableViewCell.classForCoder(), forCellReuseIdentifier: "cellIdentifier")
    }
    
    private func setUpNavigationBar() {
        
        title = "즉흥약속 잡기"
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")?
            .withTintColor(.black, renderingMode: .alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissSelf))
        navigationItem.leftBarButtonItem = backButton
       
        view.backgroundColor = .white
        
        ///그림자 추가하려고 하면 자꾸 글자 쪽에 추가되는 바람에 일단 보류.
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }


}


extension ProvinceMeetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendListTableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! ProvinceMeetTableViewCell
        cell.nameLabel.text = "김효빈"
        cell.checkBox.tag = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 48/335
    }
    
}
