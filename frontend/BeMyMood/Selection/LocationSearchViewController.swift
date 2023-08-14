//
//  EachLocationSelectionViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/13.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class LocationSearchViewController: UIViewController,UITextFieldDelegate {
    
    var locationData = ["서울 성동구 성수2가제3동", "서울 성동구 성수1가제2동", "서울 성동구 성수동2가", "서울 성동구 성수1가제1동"]
    
    var searchLocationData: [String] = []
    
    var completionHandler: ((String) -> ())?
    
    //MARK: - UIComponents
   
    let closeBtn = UIButton().then{
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let label = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "지역 선택"
    }
    
    let searchBar = UITextField().then{
        $0.clearButtonMode = .whileEditing
        $0.attributedPlaceholder = NSAttributedString(string: "동 이름으로 찾기", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkBrown])
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: $0.frame.size.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.returnKeyType = .search
    }
    
    let clearBtn = UIButton().then{
        $0.setImage(UIImage(named: "deleteText"), for: .normal)
    }
    
    let resultLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .darkBrown
        $0.text = "'성수' 검색 결과"
        $0.isHidden = true
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.allowsSelection = true
        $0.showsVerticalScrollIndicator = false
        $0.register(LocationResultCell.self, forCellWithReuseIdentifier: LocationResultCell.cellIdentifier)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        //textField
        clearBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        clearBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 13)
        clearBtn.addTarget(self, action: #selector(clearBtnDidTab), for: .touchUpInside)
        searchBar.rightView = clearBtn
        searchBar.rightViewMode = .whileEditing
        
        searchBar.delegate = self
        
        searchBar.addTarget(self, action: #selector(textFieldTextDidChange(_:)), for: .editingChanged)
        
        closeBtn.addTarget(self, action: #selector(closeBtnDidTab), for: .touchUpInside)
    }
    
    
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    @objc func clearBtnDidTab() {
        deleteResult()
    }
    
    @objc func closeBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // 키보드를 닫음
            locationSearch() // 검색 동작 수행
            
            return true
    }
    
    @objc func textFieldTextDidChange(_ textField: UITextField) {
        if self.searchBar.text == ""{
            deleteResult()
        }
    }
    
    func locationSearch(){
        guard let searchText = searchBar.text?.lowercased() else {
                   return
               }
               
        searchLocationData = locationData.filter { item in
                   return item.lowercased().contains(searchText)
               }
               
               if searchLocationData.isEmpty {
                   resultLabel.isHidden = false
                   resultLabel.text = "'" + searchText + "'" + " 검색 결과 없음"
                   collectionView.reloadData()
               } else {
                   resultLabel.isHidden = false
                   resultLabel.text = "'" + searchText + "'" + " 검색 결과"
                   collectionView.reloadData()
               }
    }
    
    func deleteResult(){
        searchBar.text = ""
        resultLabel.isHidden = true
        searchLocationData.removeAll()
        collectionView.reloadData()
    }


}
    //MARK: - CollectionViewDelegate
extension LocationSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchLocationData.isEmpty{
            return 0
        }else {
            return searchLocationData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationResultCell.cellIdentifier, for: indexPath) as? LocationResultCell else{
            fatalError()
        }
        cell.locationLabel.text = searchLocationData[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // 셀이 선택되었을 때 화면을 Pop시키는 작업 수행
        completionHandler?(searchLocationData[indexPath.row])
            // 뷰 컨트롤러를 Pop시킴
            self.navigationController?.popViewController(animated: true)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width

        let size = CGSize(width: screenWidth - 16, height: 24)
        return size
    }
}

struct LocationSearchVCPreView:PreviewProvider {
    static var previews: some View {
        LocationSearchViewController().toPreview()
    }
}
