//
//  ApiModelYS.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/17.
//

import Foundation

// MARK: - GetSpotDataDTO
struct GetSpotDataDTO: Codable {
    var spotInfos: [SpotInfo]
}

// MARK: - SpotInfo
struct SpotInfo: Codable {
    var spotId: Int
    var bookmarked: Bool
    var spotName: String
    var spotThumbnailImageUrl: String
    var categoryName: String
    var moodNames: [String]
}

// MARK: - GetSpotDetailDTO
struct GetSpotDetailDTO: Codable {
    var spotId: Int
    var bookmarked: Bool
    var categoryName: String
    var moodNames: [String]
    var spotImageUrls: [String]
    var address: String
    var contact: String?
    var operationInfo: String
    var introduce: String
}
