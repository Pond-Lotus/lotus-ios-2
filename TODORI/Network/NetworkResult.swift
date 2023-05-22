//
//  NetworkResult.swift
//  TODORI
//
//  Created by Dasol on 2023/05/02.
//

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}
