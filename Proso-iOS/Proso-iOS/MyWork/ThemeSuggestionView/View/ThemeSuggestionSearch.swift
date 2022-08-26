//
//  ThemeSuggestionSearchViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/16.
//

import UIKit
import SnapKit
import Alamofire


class ThemeSuggestionSearchViewController: UIViewController {
    
    let searchService = ThemeSearchService()

    // MARK: - 구성요소 추가
    var searchKeyword: String?
    var searchResult: [ThemeSearchModel]?
    
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14.0)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = #colorLiteral(red: 0.8861967921, green: 0.8861967921, blue: 0.8861967921, alpha: 1)
        textField.layer.cornerRadius = 8.0
        
        return textField
    }()
    
    let searchFieldIcon: UIImageView = {
        let searchIcon = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)


        let searchIconView = UIImageView(image: searchIcon)
        searchIconView.tintColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        
        return searchIconView
    }()
    
    let searchOrderByContext: [String] = [
        "가까운 순",
        "별점 높은 순",
        "리뷰 많은 순"
    ]
    
    
    let searchOrderByView: UICollectionView = {
        let viewLayout = LeftAlignedCollectionViewFlowLayout()
        viewLayout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = viewLayout
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
    
    let searchResultView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    
    
    // MARK: - 페이지 로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchData()
        hideKeyboardWhenTap()
        setUpNavigationBar()
        setupDelegate()
        addView()
        setAtrributes()
        view.backgroundColor = .white
        
        let searchTapClick = UITapGestureRecognizer(target: self, action: #selector(loadSearchData))
          searchFieldIcon.addGestureRecognizer(searchTapClick)
          searchFieldIcon.isUserInteractionEnabled = true
        
    }
  
    
    @objc func loadSearchData(){
        if let keyword = searchKeyword {
            searchService.getThemeArray(keyword){(theme: [ThemeSearchModel]) in
                self.searchResult = theme
            }
        }else{
            return
        }
        searchField.text = searchKeyword

    }
  
    
    // MARK: - 뷰 추가
    private func addView(){
        [searchField,searchFieldIcon, searchOrderByView,searchResultView].forEach({
            view.addSubview($0)
        })
        
    }
    
    private func setupDelegate(){
        searchOrderByView.dataSource = self
        searchOrderByView.delegate = self
        searchOrderByView.register(SearchByOrderCollectionViewCell.self,
                                    forCellWithReuseIdentifier: SearchByOrderCollectionViewCell.identifier)
        
        searchResultView.dataSource = self
        searchResultView.delegate = self
        searchResultView.register(SearchThemeTableViewCell.classForCoder(), forCellReuseIdentifier: "cellIdentifier")
    }
    

    private func setAtrributes(){
        
        //let buttonSize: CGSize = searchOrderByDistance.titleLabel!.text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)])
        
        
        searchField.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40) ///나중에 바꿀 예정
        }
        
        searchFieldIcon.snp.makeConstraints{
            $0.top.equalTo(searchField.snp.top).offset(9.8)
            $0.bottom.equalTo(searchField.snp.bottom).offset(-9.8)
            $0.trailing.equalTo(searchField.snp.trailing).offset(-13.8)
            $0.width.equalTo(searchFieldIcon.snp.height)
        }
        
        searchOrderByView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(searchField.snp.bottom).offset(20)
        }
        
        searchOrderByView.heightAnchor.constraint(equalTo: searchOrderByView.widthAnchor, multiplier: 26/335).isActive = true
        
        searchResultView.snp.makeConstraints{
            $0.top.equalTo(searchOrderByView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            
        }
        
    }
    
    @objc func gotoThemeInfo(){
        self.navigationController?.pushViewController(ThemeInfoViewController(), animated: true)
    }
    
    private func setUpNavigationBar() {
        title = "검색"
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
        navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - 임시


extension ThemeSuggestionSearchViewController: UICollectionViewDataSource{
    
    // MARK: - 셀 갯수 구하기
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - 셀 정보 설정
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchByOrderCollectionViewCell.identifier,
            for: indexPath) as! SearchByOrderCollectionViewCell ///FoodCell로 Downcasting
        
        let context = searchOrderByContext[indexPath.row] ///음식 컬렉션 뷰이므로 음식 해쉬태그 배열 불러옴, indexPath.row로 Index 지정
        cell.setup(with: context) ///불러온 해쉬태그 정보를 바탕으로 셀의 텍스트 지정
        return cell
        
        
    }
}
// MARK: - 해쉬태그 콜렉션 뷰 Delegate 설정 -> 버튼 선택 시 색 변경, 최대 선택수 제한, 셀 크기 글자 수에 맞춰 크기 설정
extension ThemeSuggestionSearchViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - 셀을 선택했을 때
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! SearchByOrderCollectionViewCell
        selectedCell.orderLabel.textColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        selectedCell.contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        selectedCell.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    
    
    // MARK: - 셀 선택을 해제했을 때
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! SearchByOrderCollectionViewCell
        selectedCell.orderLabel.textColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        selectedCell.contentView.layer.borderColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        selectedCell.contentView.layer.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        
        
    }
    
    // MARK: - 각 셀들의 크기를 글자 수에 맞게 설정하기 위한 함수
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var str: String
        
        
        str = searchOrderByContext[indexPath.row]
        
        let font: UIFont = .systemFont(ofSize: 14.0)
        let size: CGSize = str.size(withAttributes: [NSAttributedString.Key.font: font])
        
        return CGSize(width: size.width+24, height: size.height+8)
    }
}

extension ThemeSuggestionSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = searchResult{
            return result.count
        }else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! SearchThemeTableViewCell
        cell.selectionStyle = .none

        if let result = searchResult{
            cell.setup(with: result[indexPath.row])
            print("df")
            return cell
        }else{
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 234/335
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //클릭한 셀의 이벤트 처리
        tableView.deselectRow(at: indexPath, animated: false)
        print("click")
        let rootVC = ThemeInfoViewController()
        guard let result = searchResult else {return}
        rootVC.themeInfoId = result[indexPath.row].themeID
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
}
