//
//  FilterOption.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/13.
//

import UIKit

class FilterOption: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        backgroundColor = .clear

        setTitle(title, for: .normal)
        setImage(UIImage(systemName: "chevron.down"), for: .normal)

        tintColor = .lightGray
        setTitleColor(.lightGray, for: .normal)
        setTitleColor(.orange, for: .selected)

        semanticContentAttribute = .forceRightToLeft

        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0

        // 내부 간격 설정
        /// TODO
        /// 'contentEdgeInsets' was deprecated in iOS 15.0: This property is ignored when using UIButtonConfiguration
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
