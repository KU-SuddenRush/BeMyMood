//
//  ApiClientYS.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/17.
//

import Foundation
import Alamofire

let baseURL = "http://52.78.132.135"

extension ApiClient {
    
    // 리뷰 상세 보기
    static func getSpotInfos(completion: @escaping (Swift.Result<GetSpotDataDTO, Error>) -> Void) {
        let requesetUrl = baseURL + "/spot/info/all"
        
        print("* 리뷰 상세 보기 API 호출")
        
        AF.request(requesetUrl, method: .get)
            .responseDecodable(of: GetSpotDataDTO.self) { response in
                
                switch response.result {
                case .success(let getReviewDetailDTO):
                    completion(.success(getReviewDetailDTO))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}

