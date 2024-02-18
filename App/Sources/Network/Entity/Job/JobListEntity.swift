//
//  JobListEntity.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

struct JobListEntity: Decodable {
    let id: Int
    let title: String
    let content: String
    let specialNote: String
    let tags: [String]
    let urls: [String]
}
