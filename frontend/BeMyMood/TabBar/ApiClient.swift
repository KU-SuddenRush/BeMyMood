//
//  ApiClient.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import Alamofire

class ApiClient{
    func login(_ viewController : LoginViewController, _ parameter: LoginInput){
        AF.request("http://52.78.132.135:8080/auth/signin", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: Interceptor()).validate().responseDecodable(of: LoginModel.self) { response in
            switch response.result {
            case .success(let result):
                print("로그인 성공",result)
                if let
                    header = response.response?.allHeaderFields as? [String: String],
                   let URL = response.request?.urlRequest?.url
                {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: header, for: URL)
                    print(cookies)
                }
                let homeVC = TabBarController()
                viewController.navigationController?.pushViewController(homeVC, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
