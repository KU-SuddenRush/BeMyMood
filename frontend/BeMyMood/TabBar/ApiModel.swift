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

struct StringModel : Decodable {
    var response : String?
}

