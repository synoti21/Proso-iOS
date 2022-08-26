//
//  RandomSelectedViewController.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/08.
//

import UIKit
import SnapKit

class RandomSelectedViewController: UIViewController {
    
    var scrollView = UIScrollView()
    let contentView = UIView()
    let mapView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        
        return view
    }()
    let infoView = UIView()
    let kindOfStoreLabel: UILabel = {
        let label = UILabel()
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = .secondaryColor
        label.textColor = .white
        label.text = "카페/음식점"
        
        return label
    }()
    let storeNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "투썸플레이스 인하대후문점"
        label.textColor = .black
        
        return label
    }()
    let distanceLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondNaturalColor
        label.text = "92m"
        
        return label
    }()
    let distanceDivider: UIView = {
        let view = UIView()
        
        view.backgroundColor = .secondNaturalColor
        
        return view
    }()
    let takenTimeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondNaturalColor
        label.text = "내 위치에서 도보 5분"
        
        return label
    }()
    let locationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "map.fill"))
        
        imageView.tintColor = .secondNaturalColor
        
        return imageView
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondNaturalColor
        label.text = "인천 미추홀구 이나로 75 2-3층"
        
        return label
    }()
    let phoneImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "phone.fill"))
        
        imageView.tintColor = .secondNaturalColor
        
        return imageView
    }()
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .secondNaturalColor
        label.text = "032-861-0035"
        
        return label
    }()
    let divider: UIView = {
        let view = UIView()
        
        view.backgroundColor = .thirdNaturalColor
        
        return view
    }()
    let reviewTitle: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "리뷰(12)"
        label.textColor = .black
        
        return label
    }()
    let reivewTableView = UITableView()
    let findRoadVIew: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 20
        
        return view
    }()
    let findRoadButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .primaryColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = "길찾기"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        
        button.addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        return button
    }()
    
    
    var mode: ScrollMode = .mapMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attributes()
        layout()
    }
    
    private func settingNavigationBarAndTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        standardAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = standardAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        
        
        title = "내 주변 즉흥 장소"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingNavigationBarAndTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setUpNavigationItems(items: [.back])
    }
    
    private func attributes(){
        scrollView.bounces = false
        scrollView.delegate = self
        
        mapView.isUserInteractionEnabled = false
        
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 12
        infoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        infoView.layer.masksToBounds = false
        infoView.layer.shadowColor = UIColor.black.withAlphaComponent(1).cgColor
        infoView.layer.shadowOffset = CGSize(width: 0, height: 0)
        infoView.layer.shadowOpacity = 0.5
        infoView.layer.shadowRadius = 20
        
        locationImageView.heightAnchor.constraint(equalTo: locationImageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
        findRoadButton.heightAnchor.constraint(equalTo: findRoadButton.widthAnchor, multiplier: 56.0/335).isActive = true
        phoneImageView.heightAnchor.constraint(equalTo: phoneImageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
        
        reivewTableView.delegate = self
        reivewTableView.dataSource = self
        reivewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
        
        reivewTableView.backgroundColor = .white
        reivewTableView.separatorStyle = .none
        
        findRoadButton.addTarget(self, action: #selector(tapFindRoadButton(_:)), for: .touchUpInside)
    }
    
    private func layout(){
        [kindOfStoreLabel, storeNameLabel, distanceLabel, distanceDivider, takenTimeLabel, locationImageView, locationLabel, phoneImageView, phoneNumberLabel, divider, reviewTitle, reivewTableView,].forEach {
            infoView.addSubview($0)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.backgroundColor = .black
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalTo(0)
            $0.width.equalToSuperview()
            $0.height.equalTo(1330)
        }
        
        contentView.addSubview(mapView)
        mapView.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(600)
        }
        
        contentView.addSubview(findRoadVIew)
        findRoadVIew.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(102)
        }
        
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalTo(findRoadVIew.snp.top).offset(10)
            $0.top.equalTo(mapView.snp.bottom).offset(-10)
        }
        
        contentView.bringSubviewToFront(findRoadVIew)

        kindOfStoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(20)
        }
        
        storeNameLabel.snp.makeConstraints {
            $0.top.equalTo(kindOfStoreLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(storeNameLabel.snp.bottom).offset(8)
        }
        
        distanceDivider.snp.makeConstraints {
            $0.leading.equalTo(distanceLabel.snp.trailing).offset(8)
            $0.top.equalTo(distanceLabel.snp.top)
            $0.height.equalTo(distanceLabel.snp.height)
            $0.width.equalTo(1)
        }
        
        takenTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(distanceDivider.snp.trailing).offset(8)
            $0.top.equalTo(distanceDivider.snp.top)
        }
        
        locationImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(distanceLabel.snp.bottom).offset(40)
            $0.height.equalTo(distanceLabel.snp.height)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationImageView.snp.trailing).offset(14)
            $0.centerY.equalTo(locationImageView.snp.centerY)
        }
        
        phoneImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.height.equalTo(locationImageView.snp.height)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(phoneImageView.snp.trailing).offset(14)
            $0.centerY.equalTo(phoneImageView.snp.centerY)
        }
        
        divider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(phoneImageView.snp.bottom).offset(30)
            $0.height.equalTo(1)
        }
        
        reviewTitle.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(20)
        }
        
        reivewTableView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(reviewTitle.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        findRoadVIew.addSubview(findRoadButton)
        findRoadButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc private func tapFindRoadButton(_ sender: Any){
        
        let temp = BottomSheetViewController()
        temp.modalPresentationStyle = .overFullScreen
        present(temp, animated: false)
    }
}

extension RandomSelectedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as? ReviewTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView{
            switch mode {
            case .mapMode:
                if scrollView.contentOffset.y >= mapView.frame.height * 0.2 {
                    UIView.animate(withDuration: 0.4, delay: 0, animations: {
                        scrollView.setContentOffset(CGPoint(x: 0, y: self.mapView.frame.height),animated: false)
                    }) { _ in
                        self.mode.changeMode()
                    }
                }
            case .infoMode:
                if scrollView.contentOffset.y >= mapView.frame.height {
                    scrollView.setContentOffset(CGPoint(x: 0, y: self.mapView.frame.height),animated: false)
                }
                if scrollView.contentOffset.y <= mapView.frame.height * 0.8 {
                    UIView.animate(withDuration: 0.4, delay: 0, animations: {
                        scrollView.setContentOffset(CGPoint(x: 0, y: 0),animated: false)
                    }) { _ in
                        self.mode.changeMode()
                    }
                }
            }
        }
    }
}

enum ScrollMode {
    case mapMode
    case infoMode
    
    mutating func changeMode() {
        switch self {
        case .mapMode:
            self = .infoMode
        case .infoMode:
            self = .mapMode
        }
    }
}
class BottomSheetViewController: UIViewController {
    
    let bottomHeight: CGFloat = 190
    
    private let dimmedBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        return view
    }()
    private let openKakaoMapButton: UIButton = {
        let button = UIButton()
        
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.primaryColor.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        
        let label = UILabel()
        label.text = "카카오 맵으로 찾기"
        label.textColor = .primaryColor
        label.font = UIFont.systemFont(ofSize: 16)
        
        button.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return button
    }()
    private let openWebMapButton: UIButton = {
        let button = UIButton()
        
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.primaryColor.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        
        let label = UILabel()
        label.text = "웹 맵으로 찾기"
        label.textColor = .primaryColor
        label.font = UIFont.systemFont(ofSize: 16)
        
        button.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return button
    }()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }

    // MARK: - @Functions
    // UI 세팅 작업
    private func setupUI() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        bottomSheetView.addSubview(openKakaoMapButton)
        bottomSheetView.addSubview(openWebMapButton)
        
        dimmedBackView.alpha = 0.0
        setupLayout()
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    // 레이아웃 세팅
    private func setupLayout() {
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(102)
        }
        
        dimmedBackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSheetView.snp.top).offset(20)
        }
        
        openKakaoMapButton.heightAnchor.constraint(equalTo: openKakaoMapButton.widthAnchor, multiplier: 56.0/335).isActive = true
        openWebMapButton.heightAnchor.constraint(equalTo: openWebMapButton.widthAnchor, multiplier: 56.0/335).isActive = true
        
        openKakaoMapButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(24)
        }
        
        openWebMapButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(openKakaoMapButton.snp.bottom).offset(8)
        }
        
    }
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
       
        bottomSheetView.snp.updateConstraints {
            $0.height.equalTo(190)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
      
        bottomSheetView.snp.updateConstraints {
            $0.height.equalTo(102)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}
