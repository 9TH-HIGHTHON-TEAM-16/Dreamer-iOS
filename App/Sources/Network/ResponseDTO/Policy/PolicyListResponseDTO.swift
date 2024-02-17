//
//  PolicyListResponseDTO.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation

struct PolicyListResponseDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let subject: String
    let urls: [String]

    var toDomain: PolicyListEntity {
        return PolicyListEntity(
            id: id,
            title: title,
            content: content,
            subject: subject,
            urls: urls
        )
    }
}
