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
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)

        setImage(UIImage(named: "chevron.down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        setImage(UIImage(named: "chevron.down.fill")?.withRenderingMode(.alwaysOriginal), for: .selected)

        setTitleColor(UIColor.darkBrown_80, for: .normal)
        setTitleColor(UIColor.orange, for: .selected)

        semanticContentAttribute = .forceRightToLeft

        layer.borderColor = UIColor.darkBrown_80.cgColor
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
