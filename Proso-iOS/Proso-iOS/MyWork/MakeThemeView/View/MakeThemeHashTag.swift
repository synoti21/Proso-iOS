//
//  MakeThemeViewController.swift
//  Proso-iOS
//
//  Created by 안지완 on 2022/08/06.
//

import Foundation
import UIKit
import SnapKit

class MakeThemeThirdViewController: UIViewController, UICollectionViewDelegate, MTMapViewDelegate{
        
    var mapview: MTMapView!
    var selectedCount = 0
    var createdTheme: ThemeCreateModel?

    
    var foodHashTags = MakeThemeDefaultHashTagModel().getDefaultHashTag("food")
    var cafeHashTags = MakeThemeDefaultHashTagModel().getDefaultHashTag("cafe")
    var activityHashTags = MakeThemeDefaultHashTagModel().getDefaultHashTag("activity")
    
// MARK: - 구성 요소 추가
    let progressBar: UIProgressView = { ///진행 뷰
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
        progressView.progress = 0.495
        return progressView
    }()
    
    let themeQustion: UILabel = { ///테마 만들기 질문
        let label = UILabel()
        label.text = "테마에 맞는 해쉬태그를\n선택해주세요. (최대 3개)"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.2
        
        ///행 간 간격을 설정하기 위한 코드, 질문이 두줄 이므로 추가 설정
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        
        return label
    }()
  
// MARK: - 해쉬태그 선택 버튼 뷰
    let foodLabel: UILabel = {
        let label = UILabel()
        label.text = "음식 관련"
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2

        return label
    }()
    
    let foodCollectionView: UICollectionView = { //음식 해쉬태그 콜렉션 뷰
        let viewLayout = LeftAlignedCollectionViewFlowLayout() ///왼쪽으로 해쉬태그 버튼 정렬하기 위한 레이아웃
        viewLayout.minimumLineSpacing = 12
        viewLayout.minimumInteritemSpacing = 12 //버튼 간 간격
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = viewLayout
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true

        let items = collectionView.indexPathsForSelectedItems ///선택한 아이템을 가져오기 위한 용도
        
        return collectionView
    }()
    
    let cafeLabel: UILabel = {
        let label = UILabel()
        label.text = "카페 관련"
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2

        return label
    }()
    
    
    let cafeCollectionView: UICollectionView = { ///카페 해쉬태그 콜렉션 뷰, 밑의 코드는 위의 음식 콜렉션 뷰와 동일함
        let viewLayout = LeftAlignedCollectionViewFlowLayout()
        viewLayout.minimumLineSpacing = 12
        viewLayout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = viewLayout
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true

        let items = collectionView.indexPathsForSelectedItems

        return collectionView
    }()
    
    let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "액티비티 관련"
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2

        return label
    }()
    
    let activityCollectionView: UICollectionView = {
        let viewLayout = LeftAlignedCollectionViewFlowLayout()
        viewLayout.minimumLineSpacing = 12
        viewLayout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewLayout)
        collectionView.isScrollEnabled = false
        collectionView.collectionViewLayout = viewLayout
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true

        let items = collectionView.indexPathsForSelectedItems

        return collectionView
    }()
    
  
   
// MARK: -
    
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
        setUpNavigationBar()
        addView()
        setupViews()
        setAtrributes()
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
        
      
        nextButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(56)
        }
        
        foodLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(themeQustion.snp.bottom).offset(28)
        }
        
        foodCollectionView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(foodLabel.snp.bottom).offset(12)
            $0.height.equalTo(68)
        }
        
        cafeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(foodCollectionView.snp.bottom).offset(20)
        }
        
        cafeCollectionView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(cafeLabel.snp.bottom).offset(12)
            $0.height.equalTo(68)

        }
        
        activityLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(cafeCollectionView.snp.bottom).offset(28)
        }
        
        activityCollectionView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(activityLabel.snp.bottom).offset(12)
            $0.height.equalTo(68)

        }
        
       nextButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
// MARK: - 컴포넌트 추가 및 상단 네비게이션 바 설정
    private func addView(){
        [progressBar,themeQustion,nextButton,foodLabel,foodCollectionView,cafeLabel,cafeCollectionView,activityLabel,activityCollectionView].forEach({
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
    }
    
// MARK: - 해쉬태그 뷰 datasource, delegate 설정
    private func setupViews(){
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
        foodCollectionView.register(FoodCell.self,
                                    forCellWithReuseIdentifier: FoodCell.identifier)
        
        cafeCollectionView.dataSource = self
        cafeCollectionView.delegate = self
        cafeCollectionView.register(CafeCell.self,
                                    forCellWithReuseIdentifier: CafeCell.identifier)
        
        activityCollectionView.dataSource = self
        activityCollectionView.delegate = self
        activityCollectionView.register(ActivityCell.self,
                                        forCellWithReuseIdentifier: ActivityCell.identifier)
    }
     
    
// MARK: - 다음으로 이동
    @objc private func didTapButton(){
        
        ///TextView의 Text를 불러와 서버에 넣는 코드. 또는 다음 뷰 컨트롤러에 정보 전달

        let rootVC = MakeThemeFourthViewController()
        rootVC.createdTheme = createdTheme
        self.navigationController?.pushViewController(rootVC, animated: false)
    }
}
// MARK: - 해쉬태그 Collection View DataSource 설정
extension MakeThemeThirdViewController: UICollectionViewDataSource{
    
    // MARK: - 셀 갯수 구하기
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.foodCollectionView {
            return foodHashTags.count
        }else if collectionView == self.cafeCollectionView {
            return cafeHashTags.count
        }else{
            return self.activityHashTags.count
        }
    }
    
    // MARK: - 셀 정보 설정
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodCollectionView { ///콜렉션 뷰가 세 개이므로, 각 콜렉션 뷰를 분류해야함

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FoodCell.identifier,
                for: indexPath) as! FoodCell ///FoodCell로 Downcasting
            
            let food = foodHashTags[indexPath.row] ///음식 컬렉션 뷰이므로 음식 해쉬태그 배열 불러옴, indexPath.row로 Index 지정
            cell.setup(with: food) ///불러온 해쉬태그 정보를 바탕으로 셀의 텍스트 지정
            return cell
            
        }else if collectionView == self.cafeCollectionView {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CafeCell.identifier,
                for: indexPath) as! CafeCell
            
            let cafe = cafeHashTags[indexPath.row]
            cell.setup(with: cafe)

            return cell
        }else{

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ActivityCell.identifier,
                for: indexPath) as! ActivityCell
            
            let activity = activityHashTags[indexPath.row]
            cell.setup(with: activity)

            return cell
        }
    }
}
// MARK: - 해쉬태그 콜렉션 뷰 Delegate 설정 -> 버튼 선택 시 색 변경, 최대 선택수 제한, 셀 크기 글자 수에 맞춰 크기 설정
extension MakeThemeThirdViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - 셀을 선택했을 때
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == foodCollectionView){
            let selectedCell = collectionView.cellForItem(at: indexPath) as! FoodCell
            selectedCell.foodLabel.textColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            
        }else if(collectionView == cafeCollectionView){
            let selectedCell = collectionView.cellForItem(at: indexPath) as! CafeCell
            selectedCell.cafeLabel.textColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            
        }else{
            let selectedCell = collectionView.cellForItem(at: indexPath) as! ActivityCell
            selectedCell.activityLabel.textColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        }
        
        selectedCount += 1

        if(selectedCount > 0 && selectedCount <= 3){
            nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
            nextButton.isEnabled = true
        }else{
            nextButton.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
            nextButton.isEnabled = false
        }
    }
    
    // MARK: - 셀 선택을 해제했을 때
    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath) {
        
        if(collectionView == foodCollectionView){
            
            let selectedCell = collectionView.cellForItem(at: indexPath) as! FoodCell
            selectedCell.foodLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            
        }else if(collectionView == cafeCollectionView){
            
            let selectedCell = collectionView.cellForItem(at: indexPath) as! CafeCell
            selectedCell.cafeLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            
        }else{
            
            let selectedCell = collectionView.cellForItem(at: indexPath) as! ActivityCell
            selectedCell.activityLabel.textColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            
        }
        selectedCount -= 1
        
        if(selectedCount > 0 && selectedCount <= 3){
            nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.4265864491, blue: 0.4015736282, alpha: 1)
            nextButton.isEnabled = true
        }else{
            nextButton.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
            nextButton.isEnabled = false
        }
        
    }
    
    // MARK: - 각 셀들의 크기를 글자 수에 맞게 설정하기 위한 함수
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var str: String
        
        if collectionView == foodCollectionView{
            str = foodHashTags[indexPath.row].context

        }else if collectionView == cafeCollectionView{
            str = cafeHashTags[indexPath.row].context
        }else{
            str = activityHashTags[indexPath.row].context
        }
        let font: UIFont = .systemFont(ofSize: 14.0)
        let size: CGSize = str.size(withAttributes: [NSAttributedString.Key.font: font])

        return CGSize(width: size.width+24, height: size.height+8)
    }
}
// MARK: - 해쉬 태그 콜렉션 뷰 셀들을 왼쪽으로 정렬하기 위한 레이아웃 커스텀 설정
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributes = super.layoutAttributesForElements(in: rect)
    
    var leftMargin = sectionInset.left
    var maxY: CGFloat = -1.0
    attributes?.forEach { layoutAttribute in
      if layoutAttribute.representedElementCategory == .cell {
        if layoutAttribute.frame.origin.y >= maxY {
          leftMargin = sectionInset.left
        }
        layoutAttribute.frame.origin.x = leftMargin
        leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
        maxY = max(layoutAttribute.frame.maxY, maxY)
      }
    }
    return attributes
  }
}
