//
//  RandomSelectedViewController.swift
//  Proso-iOS
//
//  Created by changgyo seo on 2022/08/08.
//

import UIKit
import SnapKit

class AddNewPlaceViewController: UIViewController {
    
    var scrollView = UIScrollView()
    let contentView = UIView()
    let mapView: MTMapView = {
        let view = MTMapView()
       
        
        return view
    }()
    let infoView = UIView()
    
    
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
    }
    
    private func layout(){
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
        
        contentView.addSubview(infoView)
        infoView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(mapView.snp.bottom).offset(-10)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func tapFindRoadButton(_ sender: Any){
        
        let temp = BottomSheetViewController()
        temp.modalPresentationStyle = .overFullScreen
        present(temp, animated: false)
    }
}

extension AddNewPlaceViewController: UITableViewDelegate, UITableViewDataSource {
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
