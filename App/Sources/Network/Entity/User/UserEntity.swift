//
//  UserEntity.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation

struct UserEntity: Decodable {
    let psychology: String
    let type: String
}

struct UserInfoEntity: Decodable {
    let name: String
    let psychology: String
    let type: String
}
