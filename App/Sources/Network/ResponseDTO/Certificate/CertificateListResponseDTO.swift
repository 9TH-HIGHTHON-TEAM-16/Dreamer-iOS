//
//  CertificateListResponseDTO.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation

struct CertificateListResponseDTO: Decodable {
    let id: Int
    let title: String
    let content: String
    let specialNote: String
    let url: String
    let urls: [String]

    var toDomain: CertificateListEntity {
        return CertificateListEntity(
            id: id,
            title: title,
            content: content,
            specialNote: specialNote,
            url: url,
            urls: urls
        )
    }
}
