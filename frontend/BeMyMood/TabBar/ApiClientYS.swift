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
    
    // 전체 스팟 조회
    static func getSpotInfos(completion: @escaping (Swift.Result<GetSpotDataDTO, Error>) -> Void) {
        let requestUrl = baseURL + "/spot/info/all"
        
        print("* 전체 스팟 조회 API 호출")
        
        AF.request(requestUrl, method: .get)
            .responseDecodable(of: GetSpotDataDTO.self) { response in
                
                switch response.result {
                case .success(let getSpotDataDTO):
                    completion(.success(getSpotDataDTO))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    // 필터링 스팟 조회
    static func getSpotInfosWithFilter(category:String?, location:String?, mood:String?, completion: @escaping (Swift.Result<GetSpotDataDTO, Error>) -> Void) {

        var requestUrl = baseURL + "/spot/info/filter?"
        print("mood in api")
        print(mood)

        if let category = category, let categoryIndex = Data.categoryData.firstIndex(of: category){
            requestUrl += "category_id=" + String(categoryIndex + 1) + "&"
        }
        if let location = location, let locationIndex = Data.locationData.firstIndex(where: { $0.contains(location) }) {
            requestUrl += "location_id=" + String(locationIndex + 1) + "&"
        }
        if let mood = mood, let moodIndex = Data.moodData.firstIndex(of: "#" + mood){
            requestUrl += "mood_id=" + String(moodIndex + 1) + "&" // DB 저장구조상 태그가 mood 와
        }
        
        print("* 필터링 스팟 조회 API 호출")
        print(requestUrl)

        AF.request(requestUrl, method: .get)
            .responseDecodable(of: GetSpotDataDTO.self) { response in
                
                switch response.result {
                case .success(let getSpotDataDTO):
                    completion(.success(getSpotDataDTO))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // 스팟 상세 조회
    static func getSpotDetailInfo(spotId: Int, completion: @escaping (Swift.Result<GetSpotDetailDTO, Error>) -> Void) {

        var requestUrl = baseURL + "/spot/" + String(spotId) + "/detail"
        
        print("* 스팟 상세 조회 API 호출")
        print(requestUrl)

        AF.request(requestUrl, method: .get)
            .responseDecodable(of: GetSpotDetailDTO.self) { response in
                
                switch response.result {
                case .success(let getSpotDetailDTO):
                    completion(.success(getSpotDetailDTO))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

