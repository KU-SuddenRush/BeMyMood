//
//  DetailViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    
    var tempData: SpotDetailInfos!
        
    //MARK: - UIComponents
    private let scrollView = UIScrollView()
    private let contentView = DetailVerticalScrollContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.tempData = self.tempData
        
        setViews()
        setViewConstraints()
        
        self.scrollView.delegate = self
    }
    
    func setViews(){
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.backgroundColor = .brown
        contentView.backgroundColor = .systemPink
    }
    
    func setViewConstraints(){
        configurationVerticalScrollViewConstraint()
        configureContentViewConstraint()
    }
    
    func configurationVerticalScrollViewConstraint() {
        scrollView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureContentViewConstraint(){
        contentView.snp.makeConstraints{ make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
    }
}

extension DetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolled")
    }
}

struct DetailVCPreView:PreviewProvider {
    static var previews: some View {
        DetailViewController().toPreview()
    }
}
