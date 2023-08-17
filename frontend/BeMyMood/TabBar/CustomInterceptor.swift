//
//  CustomInterceptor.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import Alamofire

class CustomInterceptor: RequestInterceptor {
    private let sessionID: String
    
    init(sessionID: String) {
        self.sessionID = sessionID
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        // 서버에서 받아온 세션 쿠키를 헤더에 추가
        urlRequest.setValue("JSESSIONID=\(sessionID)", forHTTPHeaderField: "Cookie")
        
        completion(.success(urlRequest))
    }
    
    // 이하 메서드는 필요에 따라 구현하고, 아무 작업을 하지 않아도 됩니다.
}

