//
//  UserResponseDTO.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation

struct UserResponseDTO: Decodable {
    let psychology: String
    let type: String

    var toDomain: UserEntity {
        return UserEntity(
            psychology: psychology, type: type
        )
    }
}

struct UserInfoResponseDTO: Decodable {
    let name: String
    let psychology: String
    let type: String
    
    var toDomain: UserInfoEntity {
        return UserInfoEntity(name: name, psychology: psychology, type: type)
    }
}
