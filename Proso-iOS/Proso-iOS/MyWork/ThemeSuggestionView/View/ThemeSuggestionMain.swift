//
//  ThemeMainViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/06.
//

import UIKit
import Alamofire
import SnapKit



class ThemeSuggestionMainViewController: UIViewController{
    
    
    let PopularThemeService = ThemeSuggestionService()
    let risingThemeService = RisingThemeService()
    let bookmarkService = ThemeBookmarkService()
    let refreshControl = UIRefreshControl()
    
    var risingThemeArray: ThemeRisingModel?
    var popularCafeThemeArray: ThemeSuggestionModel?
    var popularFoodThemeArray: ThemeSuggestionModel?


    
// MARK: - 구성요소 추가
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색어를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14.0)
        textField.textColor = .black
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
    // MARK: - 요즘 뜨는 테마
    let risingThemeSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "요즘 뜨는 테마"
        label.textColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    let risingThemeIntroduction: UILabel = {
        let label = UILabel()
        label.text = "더운 여름날은 시원한 이곳에서!" ///추후 서버에서 데이터를 받아 수정할 예정
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    let risingThemeInfoView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - 인기 테마
    
    
    let popularThemeCafeSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "인기 테마"
        label.textColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    let popularThemeCafeIntroduction: UILabel = {
        let label = UILabel()
        label.text = "인스타 감성 낭낭한 카페 모음" ///추후 서버에서 데이터를 받아 수정할 예정
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    let popularThemeCafeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .red
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let popularThemeFoodSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "인기 테마"
        label.textColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12.0)
        
        return label
    }()
    
    let popularThemeFoodIntroduction: UILabel = {
        let label = UILabel()
        label.text = "피드 업데이트용 레스토랑 모음" ///추후 서버에서 데이터를 받아 수정할 예정
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    let popularThemeFoodCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .gray
        return collectionView
    }()
    
        
    
// MARK: -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setUpNavigationItems(items: [.logo,.bell,.add])
        loadRisingThemeModel()
        hideKeyboardWhenTap()
        loadPopularThemeModel()
        collectionViewDelegate()
        tableViewDelegate()
        addView()
        setLayout()
        
        let searchTapClick = UITapGestureRecognizer(target: self, action: #selector(gotoSearchResult))
          searchFieldIcon.addGestureRecognizer(searchTapClick)
          searchFieldIcon.isUserInteractionEnabled = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "피드를 업데이트 하려면 당기세요")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        mainScrollView.refreshControl = refreshControl
       
        view.backgroundColor = .white
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false){timer in
            self.loadRisingThemeModel()
            self.loadPopularThemeModel()
            self.risingThemeInfoView.reloadData()
            self.popularThemeFoodCollectionView.reloadData()
            self.popularThemeCafeCollectionView.reloadData()
            
            self.refreshControl.endRefreshing()
        }
        
    }
  
   
    
    
    @objc func gotoSearchResult(){
        let rootVC = ThemeSuggestionSearchViewController()
        rootVC.searchKeyword = searchField.text ?? String()
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    private func collectionViewDelegate(){
        popularThemeCafeCollectionView.dataSource = self
        popularThemeCafeCollectionView.delegate = self
        popularThemeCafeCollectionView.register(ThemeCollectionViewCell.self, forCellWithReuseIdentifier: ThemeCollectionViewCell.identifier)
        
        popularThemeFoodCollectionView.dataSource = self
        popularThemeFoodCollectionView.delegate = self
        popularThemeFoodCollectionView.register(ThemeCollectionViewCell.self, forCellWithReuseIdentifier: ThemeCollectionViewCell.identifier)
    }
    
    private func tableViewDelegate(){
        risingThemeInfoView.delegate = self
        risingThemeInfoView.dataSource = self
        risingThemeInfoView.register(RisingThemeTableViewCell.classForCoder(), forCellReuseIdentifier: "cellIdentifier")
    }

   
    private func addView(){
        [searchField,searchFieldIcon,risingThemeSectionLabel, risingThemeIntroduction,risingThemeInfoView,popularThemeCafeSectionLabel,popularThemeCafeIntroduction,popularThemeCafeCollectionView, popularThemeFoodSectionLabel, popularThemeFoodIntroduction, popularThemeFoodCollectionView].forEach({
            contentView.addSubview($0)
        })
        mainScrollView.addSubview(contentView)
        self.view.addSubview(mainScrollView)
        
    }
    
    private func setLayout(){
        mainScrollView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        searchField.snp.makeConstraints{
            $0.top.equalToSuperview().inset(28)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        searchFieldIcon.snp.makeConstraints{
            $0.top.equalTo(searchField.snp.top).offset(9.8)
            $0.bottom.equalTo(searchField.snp.bottom).offset(-9.8)
            $0.trailing.equalTo(searchField.snp.trailing).offset(-13.8)
            $0.width.equalTo(searchFieldIcon.snp.height)
        }
        
        risingThemeSectionLabel.snp.makeConstraints{
            $0.top.equalTo(searchField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        risingThemeIntroduction.snp.makeConstraints{
            $0.top.equalTo(risingThemeSectionLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        risingThemeInfoView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(risingThemeIntroduction.snp.bottom).offset(24)
        }
        
        risingThemeInfoView.heightAnchor.constraint(equalTo: risingThemeInfoView.widthAnchor, multiplier: 296/335).isActive = true
        
      
        popularThemeCafeSectionLabel.snp.makeConstraints{
            $0.top.equalTo(risingThemeInfoView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(20)
        }
        
        popularThemeCafeIntroduction.snp.makeConstraints{
            $0.top.equalTo(popularThemeCafeSectionLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        popularThemeCafeCollectionView.snp.makeConstraints{
            $0.top.equalTo(popularThemeCafeIntroduction.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        popularThemeCafeCollectionView.heightAnchor.constraint(equalTo: popularThemeCafeCollectionView.widthAnchor, multiplier: 189/375).isActive = true
        
        
        popularThemeFoodSectionLabel.snp.makeConstraints{
            $0.top.equalTo(popularThemeCafeCollectionView.snp.bottom).offset(48)
            $0.leading.equalToSuperview().inset(20)
        }
        
        popularThemeFoodIntroduction.snp.makeConstraints{
            $0.top.equalTo(popularThemeFoodSectionLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        popularThemeFoodCollectionView.snp.makeConstraints{
            $0.top.equalTo(popularThemeFoodIntroduction.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        popularThemeFoodCollectionView.heightAnchor.constraint(equalTo: popularThemeFoodCollectionView.widthAnchor, multiplier: 189/375).isActive = true
    }
    
    private func loadRisingThemeModel(){
        risingThemeService.getThemeArray(){(theme: ThemeRisingModel) in
            self.risingThemeArray = theme
        }
    }
    
    private func loadPopularThemeModel(){
        PopularThemeService.getThemeArray("카페"){(theme: ThemeSuggestionModel) in
            self.popularCafeThemeArray = theme
        }
        
        PopularThemeService.getThemeArray("맛집"){(theme: ThemeSuggestionModel) in
            self.popularFoodThemeArray = theme
        }
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func gotoMakeTheme(_ sender: Any){
        let rootVC = MakeThemeFirstViewController()
        self.navigationController?.pushViewController(rootVC, animated: true)
    }

    
}
extension ThemeSuggestionMainViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      print("asdfasdf")
      self.view.endEditing(true)
      let rootVC = ThemeSuggestionSearchViewController()
      self.navigationController?.pushViewController(rootVC, animated: true)
      return false
  }
}




extension ThemeSuggestionMainViewController: UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == popularThemeCafeCollectionView){
            return popularCafeThemeArray?.data[0].count ?? 0
            
        }else if(collectionView == popularThemeFoodCollectionView){
            return popularFoodThemeArray?.data[0].count ?? 0
        }else {return 0}
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if(collectionView == popularThemeCafeCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionViewCell.identifier, for: indexPath) as! ThemeCollectionViewCell
            
            
            if let cafeModel = popularCafeThemeArray {
                cell.setup(with: cafeModel.data[0][indexPath.row])
                return cell
            }else{
                print("cafe not loaded")
                return cell
            }
            

        }else if(collectionView == popularThemeFoodCollectionView){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCollectionViewCell.identifier, for: indexPath) as! ThemeCollectionViewCell
            
            if let foodModel = popularFoodThemeArray {
                cell.setup(with: foodModel.data[0][indexPath.row])
                return cell
            }else{
                print("food not loaded")
                return cell
            }
            
        }else{
            print("error in collection view")
            return UICollectionViewCell()
            
        }
    }
    
}


extension ThemeSuggestionMainViewController: UICollectionViewDelegate {
    
}

extension ThemeSuggestionMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      
        return CGSize(width: view.frame.width*(219/375), height: view.frame.width*(189/375))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == popularThemeCafeCollectionView){
            collectionView.deselectItem(at: indexPath, animated: false)
            let rootVC = ThemeInfoViewController()
            rootVC.themeInfoId = popularCafeThemeArray?.data[0][indexPath.row].themeID
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }else{
            collectionView.deselectItem(at: indexPath, animated: false)
            let rootVC = ThemeInfoViewController()
            rootVC.themeInfoId = popularCafeThemeArray?.data[0][indexPath.row].themeID
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            present(navVC, animated: true)
        }
       
    }

}

extension ThemeSuggestionMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = risingThemeInfoView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! RisingThemeTableViewCell
        cell.selectionStyle = .none
        
        risingThemeService.getThemeArray(){(theme: ThemeRisingModel) in
            cell.setup(with: theme)
            ThemeInfoService().getThemeArray(theme.data.themeID){(theme: ThemeInfoModel) in
                cell.setBookmarkCount(with: theme)
            }
        }
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 292/375
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //클릭한 셀의 이벤트 처리
        tableView.deselectRow(at: indexPath, animated: false)
        print("click")
        let rootVC = ThemeInfoViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }

}

extension UIViewController{
    func hideKeyboardWhenTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
