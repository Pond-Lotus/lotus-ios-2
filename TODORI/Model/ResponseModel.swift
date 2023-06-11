//
//  ResponseModel.swift
//  TODORI
//
//  Created by Dasol on 2023/05/24.
//

import Foundation


struct ResultCodeResponse: Decodable {
    let resultCode: Int
}

struct RegisterResponse: Decodable {
    let resultCode: Int
    let account: [String: String]
}

struct LoginResponse: Decodable {
    let resultCode: Int
    let token: String?
    let nickname: String?
    let email: String?
    let image: String?
}

struct EditAccountResponse: Decodable {
    let resultCode: Int
    let data: [String: String]
}


struct ToDoResponse: Decodable {
    let resultCode: Int
    let data: [String: String]
}


