//
//  CertificateListEntity.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation

struct CertificateListEntity: Decodable {
    let id: Int
    let title: String
    let content: String
    let specialNote: String
    let url: String
    let urls: [String]
}
