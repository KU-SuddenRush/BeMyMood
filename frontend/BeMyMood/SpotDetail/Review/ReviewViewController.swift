//
//  ReviewViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var tempReviews: [SpotReview] = [
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.16", reviewImages: ["https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300"], description: "제안된 헌법개정안은 대통령이 20일 이상의 기간 이를 공고하여야 한다. 국민의 자유와 권리는 헌법에 열거되지 아니한 이유로 경시되지 아니한다. 대통령은 국무회의의 의장이 되고, 국무총리는 부의장이 된다."),
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.14", reviewImages: ["https://picsum.photos/200/300"], description: "공무원은 국민전체에 대한 봉사자이며, 국민에 대하여 책임을 진다."),
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.12", reviewImages: [], description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        SpotReview(profileImageUrl: "https://picsum.photos/200/300", nickname: getRandomNickname(), postedAt: "2023.08.11", reviewImages: ["https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300"], description: "분위기가 좋아요"),
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
