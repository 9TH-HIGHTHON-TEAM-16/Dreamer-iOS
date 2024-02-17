//
//  JobService.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Moya
import Foundation

enum JobService {
    case jobList(param: [String: Any])
}

extension JobService: TargetType {
    var baseURL: URL {
        return URL(string: "http://13.124.238.120:8080")!
    }

    var path: String {
        switch self {
        case .jobList:
            return "/job/filter/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .jobList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .jobList(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
