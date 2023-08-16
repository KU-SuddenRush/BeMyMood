//
//  MoodBottomSheet.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/14.
//

import UIKit
import PanModal


protocol FilterMoodDataDelegate: AnyObject {
    func setMoodFilterTitle(_ title: String)
}

class MoodBottomSheet: UIViewController {
    
    var moods: [String] = Data.moodData

    weak var delegate: FilterMoodDataDelegate?
    
    //MARK: - UIComponents
    private let moodBottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        moodBottomCollectionView.dataSource = self
        moodBottomCollectionView.delegate = self
        moodBottomCollectionView.register(SpotTagCell.self, forCellWithReuseIdentifier: "spotTagCell")
    }
    
}

extension MoodBottomSheet {
    
    func hierarchy(){
        view.addSubview(moodBottomCollectionView)
    }
    
    func layout(){
        moodBottomCollectionView.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.top.equalTo(40)
            make.leading.equalTo(34)
            make.trailing.equalTo(-34)
        }
    }
}

extension MoodBottomSheet: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(200)
    }
    
    var longFormHeight: PanModalHeight {
        //        return .maxHeightWithTopInset(40)
        return .contentHeight(200) // 최대 크기 == 최소 크기 == 크기 고정
    }
}

extension MoodBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let spotTagCell = moodBottomCollectionView.dequeueReusableCell(withReuseIdentifier: "spotTagCell", for: indexPath) as! SpotTagCell
        
        spotTagCell.tagLabel.text = moods[indexPath.row]
        
        return spotTagCell
    }
    
    func calculateTagCellWidth(for tagText: String) -> CGFloat {
        // 셀 폭을 계산하는 로직을 작성합니다. 텍스트의 길이에 따라 동적으로 폭을 설정하거나, 고정된 값으로 설정할 수 있습니다.
        let textWidth = tagText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width
        let cellWidth = textWidth + 40.0 // 예시로 폭에 텍스트 너비를 추가하고 여백을 더합니다.
        
        return cellWidth
    }
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = calculateTagCellWidth(for: moods[indexPath.row])
        
        return CGSize(width: cellWidth, height: 33)
    }
    
    // CollectionView Cell의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14.0
    }
    
    // CollectionView Cell의 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택된 셀에 접근
        if let selectedCell = moodBottomCollectionView.cellForItem(at: indexPath) as? SpotTagCell {
            var tagName = selectedCell.tagLabel.text ?? ""
            while tagName.hasPrefix("#"){
                tagName.removeFirst()
            }
            if tagName != ""{
                delegate?.setMoodFilterTitle(tagName)
            }
            print(tagName)
        }
        dismiss(animated: true)
    }
}
