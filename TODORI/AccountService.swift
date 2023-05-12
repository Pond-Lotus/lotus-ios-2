//
//  AccountService.swift
//  TODORI
//
//  Created by Dasol on 2023/05/02.
//

import Foundation
import Alamofire

class UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    func emailCheck(email: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        let url = APIConstant.Account.emailCode
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        let body: Parameters = [
            "email": email
        ]
        
        // 500일 때는?
        AF.request(url, method: .get, parameters: body, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        completion(.success(json))
                    } else {
                    }
                case .failure(let error):
                    completion(.networkFail)
                }
            }
    }
    
    func codeCheck(email: String, code: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        let url = APIConstant.Account.emailCode
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        let body: Parameters = [
            "email": email,
            "code": code
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        completion(.success(json))
                    } else {
                    }
                case .failure(let error):
                    completion(.networkFail)
                }
            }
    }
    
    func register(nickname: String, email: String, password: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        let url = APIConstant.Account.register
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: Parameters = [
                "nickname": nickname,
                "email": email,
                "password": password
                ]
            
            AF.request(url,
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            completion(.success(json))
                        } else {
                        }
                    case .failure(let error):
                        completion(.networkFail)
                    }
            }
        }
    
    func login(email: String, password: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        let url = APIConstant.Account.login
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    completion(.success(json))
                } else {
                }
            case .failure(let error):
                completion(.networkFail)
            }
        }
    }
    
//    func findPassword(email: String, password: String, completion: @escaping(NetworkResult<Any>) -> Void) {
//        let url = APIConstant.Account.login
//        let headers: HTTPHeaders = ["Content-Type": "application/json"]
//        let parameters: Parameters = [
//            "email": email,
//            "password": password
//        ]
//        
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let json = value as? [String: Any] {
//                    completion(.success(json))
//                } else {
//                }
//            case .failure(let error):
//                completion(.networkFail)
//            }
//        }
//    }

//
//    private func judgeStatus(by statusCode: Int, _ data: Data, _ form: UserAPI) -> NetworkResult<Any> {
//        switch statusCode {
//        case ..<300 : return isVaildData(data: data, form: form)
//        case 400..<500 : return .pathErr
//        case 500..<600 : return .serverErr
//        default : return .networkFail
//        }
//    }
//
//    private func isVaildData(data: Data, form: UserAPI) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//
//        switch form {
//        case .emailcodecheck:
//            guard let decodedData = try? decoder.decode(SignupResponse.self, from: data) else { return .pathErr }
//            return .success(decodedData as Any)
//        case .signup:
//            guard let decodedData = try? decoder.decode(SignupResponse.self, from: data) else { return .pathErr }
//            return .success(decodedData as Any)
//        case .login:
//            guard let decodedData = try? decoder.decode(LoginResponse.self, from: data) else { return .pathErr }
//            return .success(decodedData as Any)
//        case .editprofile:
//            guard let decodedData = try? decoder.decode(EditProfileResponse.self, from: data) else { return .pathErr }
//            return .success(decodedData as Any)
//        }
//    }
}


