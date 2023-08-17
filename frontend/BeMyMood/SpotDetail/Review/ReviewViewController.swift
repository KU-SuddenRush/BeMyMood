//
//  ReviewViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var tempReviews: [SpotReview] = [
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.16", reviewImages: ["https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/12.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/15.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/24.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/14.jpg","https://picsum.photos/200/300"], description: "MZ라면 꼭 가보세요. 힙 그자체"),
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.14", reviewImages: ["https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/13.jpg"], description: "사악한 가격 ,, 그러나 눈과 입이 즐거웠다"),
        SpotReview(profileImageUrl: "https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/14.jpg", nickname: getRandomNickname(), postedAt: "2023.08.12", reviewImages: ["https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/14.jpg", "https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/12.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/16.jpg", "https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/24.jpg"], description: "가족들끼리 놀러갔는데, 조금 시끄러운 느낌이 있었지만 분위기 너무 좋았어요. 플랜테리어 제대로라 완전 요즘 감성 뿜뿜 ,, 그리고 콜드브루라떼 진짜 진심 대존맛이었습니다 .."),
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.11", reviewImages: ["https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/16.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/13.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/12.jpg","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/21.jpg0","https://bemymood-bucket.s3.ap-northeast-2.amazonaws.com/spot/19.jpg"], description: "카페 내부 인테리어가 너무 멋있어요. 다만 베이커리는 너무 비싼 거 아닌가 싶었는데 맛이나 외관이나, 카페 전체적인 분위기 생각하면 괜찮은 것 같기도 해요. 정말 ‘감성적이다’라는 말이 딱 맞는 것 같아요."),
    ]
    
    //MARK: - UIComponents
    let reviewTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        layout()
        
        reviewTableView.register(ReviewCell.self, forCellReuseIdentifier: "reviewCell")
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    
}

extension ReviewViewController {
    
    func hierarchy(){
        self.view.addSubview(reviewTableView)
    }
    
    func layout(){
        reviewTableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        cell.profileImage.loadImage(from: tempReviews[indexPath.row].profileImageUrl)
        cell.nickname.text = tempReviews[indexPath.row].nickname
        cell.postedAt.text = tempReviews[indexPath.row].postedAt

//        cell.setReviewImages(tempReviews[indexPath.row].reviewImages)
        cell.reviewImageUrls = tempReviews[indexPath.row].reviewImages
        cell.reviewText.text = tempReviews[indexPath.row].description
        
        return cell
    }
}

struct SpotReview{
    let profileImageUrl: String
    let nickname: String
    let postedAt: String
    let reviewImages: [String]
    let description: String
}
