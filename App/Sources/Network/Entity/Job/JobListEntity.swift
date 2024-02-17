//
//  JobListEntity.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

struct JobListEntity: Decodable {
    let title: String
    let content: String
    let specialNote: String
    let tag: [String]
    let urls: [String]
}
