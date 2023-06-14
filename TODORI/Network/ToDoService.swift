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
    
    func searchTodo(year:String, month:String, day:String, completion:@escaping(AFResult<Any>)->Void){
        let url = APIConstant.baseURL + APIConstant.todo
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization": "Token \(token)"]
        let parameter:Parameters = [
            "year":year,
            "month": month,
            "day":day
        ]
        AF.request(url, method: .get,parameters: parameter, headers: header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String:Any] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: json, options: [])
                            let decodedData = try JSONDecoder().decode(TodoSearchResponseData.self, from: data)
                            completion(.success(decodedData))
                        } catch {
                            completion(.failure("decode error"))
                        }
                        
                    } else {
                        completion(.failure("data error"))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
        
    }
    
    func deleteTodo(id:Int, completion:@escaping(AFResult<Any>)->Void){
        let url = APIConstant.baseURL + APIConstant.todo + "\(id)/"
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization": "Token \(token)"]
        
        
        
        AF.request(url, method: .delete,headers: header)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String:Any] {
                        do{
                            let data = try JSONSerialization.data(withJSONObject: json, options: [])
                            let decodedData = try JSONDecoder().decode(ResponseData.self, from: data)
                            completion(.success(decodedData))
                        }catch{
                            completion(.failure("decode error"))
                        }
                        
                    } else {
                        completion(.failure("data error"))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func writeTodo(year:String, month:String, day:String, title:String, color:Int, completion:@escaping(AFResult<Any>)->Void){
        let url = APIConstant.baseURL + APIConstant.todo
        
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization": "Token \(token)"]
        
        let parameter:Parameters = [
            "year":year,
            "month": month,
            "day":day,
            "title":title,
            "color":color
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any] {
                    do{
                        let data = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decodedData = try JSONDecoder().decode(TodoWriteResponseData.self, from: data)
                        completion(.success(decodedData))
                    }catch{
                        completion(.failure("decode error"))
                    }
                    
                } else {
                    completion(.failure("data error"))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editTodo(title:String, description:String,colorNum:Int, time:String, id:Int, completion:@escaping(AFResult<Any>)->Void){
        let url = APIConstant.baseURL + APIConstant.todo + "\(id)/"
        
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization": "Token \(token)"]
        
        let parameter:Parameters = [
            "title" : title,
            "description": description,
            "color" : colorNum,
            "time" : time
        ]
        AF.request(url,
                   method: .put,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any] {
                    do{
                        let data = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decodedData = try JSONDecoder().decode(TodoEditResponseData.self, from: data)
                        completion(.success(decodedData))
                    }catch{
                        completion(.failure("decode error"))
                    }
                    
                } else {
                    completion(.failure("data error"))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getPriorityName(completion:@escaping(AFResult<Any>)->Void){
        let url = APIConstant.baseURL + APIConstant.category
        
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization": "Token \(token)"]
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any] {
                    do{
                        let data = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decodedData = try JSONDecoder().decode(PriorityResponseData.self, from: data)
                        completion(.success(decodedData))
                    }catch{
                        completion(.failure("decode error"))
                    }
                    
                } else {
                    completion(.failure("data error"))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editDoneTodo(done:Bool, id:Int, completion:@escaping(AFResult<Any>)->Void){
        let url = APIConstant.baseURL + APIConstant.todo + "\(id)/"
        
        guard let token = TokenManager.shared.getToken() else {
            print("No token.")
            return
        }
        let header : HTTPHeaders = ["Content-Type" : "application/json",
                                    "Authorization": "Token \(token)"]
        
        let parameter:Parameters = [
            "done":done
        ]
        AF.request(url,
                   method: .put,
                   parameters: parameter,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any] {
                    do{
                        let data = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decodedData = try JSONDecoder().decode(TodoEditResponseData.self, from: data)
                        completion(.success(decodedData))
                    }catch{
                        completion(.failure("decode error"))
                    }
                    
                } else {
                    completion(.failure("data error"))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}

