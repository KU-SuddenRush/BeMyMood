//
//  ApiModelYS.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/17.
//

import Foundation

// MARK: - GetLiquorDetailDTO
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
