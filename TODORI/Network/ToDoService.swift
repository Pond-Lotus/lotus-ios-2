//
//  ToDoService.swift
//  TODORI
//
//  Created by Dasol on 2023/05/25.
//

import UIKit
import Alamofire

class TodoService {
    
    static let shared = TodoService()
    
    private init() {}
    
    func inquireGroupName(completion: @escaping(Result<ToDoResponse, Error>) -> Void) {
        let url = APIConstant.ToDo.groupName
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        let headers: HTTPHeaders = ["Authorization" : "Token " + token]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: ToDoResponse.self) { response in
            switch response.result {
            case .success(let response):
                print("투두 조회 성공 in UserService")
                completion(.success(response))
                
            case .failure(let error):
                print("투두 조회 실패 in UserService")
                completion(.failure(error))
            }
        }
    }

    func editGroupName(first: String, second: String, third: String, fourth: String, fifth: String, sixth: String, completion: @escaping(Result<ResultCodeResponse, Error>) -> Void) {
        let url = APIConstant.ToDo.groupName
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        let headers: HTTPHeaders = ["Authorization" : "Token " + token]
        let parameters: [String: Any] = [
            "priority": [
                "1": first,
                "2": second,
                "3": third,
                "4": fourth,
                "5": fifth,
                "6": sixth
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ResultCodeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("투두 수정 성공 in UserService")
                    completion(.success(response))
                case .failure(let error):
                    print("투두 수정 실패 in UserService: \(error)")
                    completion(.failure(error))
                }
            }
    }
}
