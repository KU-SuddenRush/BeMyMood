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
