//
//  ApiModel.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//


struct LoginInput : Encodable {
    var email : String?
    var password : String?
}

struct LoginModel : Decodable {
    var memberId : Int?
    var memberName : String?
}

struct SignUpInput : Encodable {
    var name : String?
    var email : String?
    var password : String?
}

struct SignUpModel : Decodable {
    var memberId : Int?
}

struct GetTotalMoodModel : Decodable {
    var memberId : Int?
}

struct PostMyMoodInput : Encodable {
    var moodIds : [Int?]
}

struct PostLocationInput : Encodable {
    var locationIds : [Int?]
}

struct GetMyMoodModel : Decodable {
    var count : Int?
    var moodIds : [Int?]
}

struct GetMyRecordImage : Decodable {
    var count : Int
    var reviewImageParams : [MyRecordImages]
}

struct MyRecordImages : Decodable {
    var reviewImgId : Int
    var reviewImgUrl : String
}

struct GetMySpotImage : Decodable {
    var spotSignatureImageParams : [MySpotImages]
}

struct MySpotImages : Decodable {
    var spotImgId : Int
    var spotImgUrl : String
}

struct GetMyRecentMoodBoard : Decodable {
    var moodBoardInfo : MyRecentMoodBoard
    var exist : Bool
}

struct MyRecentMoodBoard : Decodable {
    var moodBoardId : Int
    var moodBoardName : String
    var moodBoardCaptureUrl : String
}

struct GetMyMoodBoards : Decodable {
    var moodBoards : [MyRecentMoodBoard]
}

struct StringModel : Decodable {
    var response : String?
}

