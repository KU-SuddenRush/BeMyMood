//
//  ApiClient.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import Alamofire

class ApiClient{
    
    let interceptor = CustomInterceptor(sessionID: UserDefaults.standard.string(forKey: "sessionID") ?? "")
    
    func login(_ viewController : LoginViewController, _ parameter: LoginInput){
        AF.request("http://52.78.132.135/auth/signin", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil).validate().responseDecodable(of: LoginModel.self) { response in
            switch response.result {
            case .success(let result):
                print("로그인 성공",result)
                if let
                    header = response.response?.allHeaderFields as? [String: String],
                   let URL = response.request?.urlRequest?.url
                {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: header, for: URL)
                    for cookie in cookies {
                        if cookie.name == "JSESSIONID" {
                            let sessionID = cookie.value
                            UserDefaults.standard.set(sessionID, forKey: "sessionID")
                            print("sessionId",sessionID)
                        }
                    }
                    print(cookies)
                }
                UserDefaults.standard.set(result.memberName, forKey: "name")
                let homeVC = TabBarController()
                viewController.navigationController?.pushViewController(homeVC, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func signUp(_ viewController : SignupViewController, _ parameter: SignUpInput){
        AF.request("http://52.78.132.135/auth/signup", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: nil, interceptor: Interceptor()).validate().responseDecodable(of: SignUpModel.self) { response in
            switch response.result {
            case .success(let result):
                print("회원가입 성공",result)
                if let
                    header = response.response?.allHeaderFields as? [String: String],
                   let URL = response.request?.urlRequest?.url
                {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: header, for: URL)
                    for cookie in cookies {
                        if cookie.name == "JSESSIONID" {
                            let sessionID = cookie.value
                            UserDefaults.standard.set(sessionID, forKey: "sessionID")
                            print("sessionId",sessionID)
                        }
                    }
                    
                }
                let signUpModal = SignUpModal()
                signUpModal.modalPresentationStyle = .overFullScreen
                signUpModal.signupVCNavigationController = viewController.navigationController
                viewController.present(signUpModal, animated: false, completion: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTotalMood(completion: @escaping ([Int]) -> Void){
        AF.request("http://52.78.132.135/mood/vibe", method: .get, parameters: nil,interceptor: interceptor).validate().responseDecodable(of: [Int].self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getTotalColor(completion: @escaping ([Int]) -> Void){
        AF.request("http://52.78.132.135/mood/color", method: .get, parameters: nil, interceptor: interceptor).validate().responseDecodable(of: [Int].self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func postMyMood(_ parameter: PostMyMoodInput, completion: @escaping (String) -> Void){
        AF.request("http://52.78.132.135/member/mood", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, interceptor: interceptor).validate().responseDecodable(of: StringModel.self) { response in
            switch response.result {
            case .success(let result):
                print("무드보내기성공")
                completion(result.response!)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion("fail" + error.localizedDescription)
            }
        }
    }
    
    func postLocation(_ parameter: PostLocationInput, completion: @escaping (String) -> Void){
        AF.request("http://52.78.132.135/member/location", method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, interceptor: interceptor).validate().responseDecodable(of: StringModel.self) { response in
            switch response.result {
            case .success(let result):
                print("지역보내기성공")
                completion(result.response!)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion("fail" + error.localizedDescription)
            }
        }
    }
    
    func getMyMood(completion: @escaping (GetMyMoodModel) -> Void){
        AF.request("http://52.78.132.135/member/mood", method: .get, parameters: nil, interceptor: interceptor).validate().responseDecodable(of: GetMyMoodModel.self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMyRecordImage(completion: @escaping (GetMyRecordImage) -> Void){
        AF.request("http://52.78.132.135/moodboard/picture/review", method: .get, parameters: nil, interceptor: interceptor).validate().responseDecodable(of: GetMyRecordImage.self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMySpotImage(completion: @escaping (GetMySpotImage) -> Void){
        AF.request("http://52.78.132.135/moodboard/picture/spot-signature", method: .get, parameters: nil, interceptor: interceptor).validate().responseDecodable(of: GetMySpotImage.self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
