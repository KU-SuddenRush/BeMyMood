//
//  Nicknames.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import Foundation

let nicknames = [
    "차홍",
    "슈가",
    "마이클",
    "에밀리",
    "제임스",
    "리나",
    "알렉스",
    "소피아",
    "디온",
    "미샤"
]

func getRandomNickname() -> String {
    let randomIndex = Int.random(in: 0..<nicknames.count)
    return nicknames[randomIndex]
}
