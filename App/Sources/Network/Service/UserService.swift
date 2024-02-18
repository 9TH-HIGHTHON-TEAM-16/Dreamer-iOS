//
//  UserService.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Moya
import Foundation

enum UserService {
    case user(param: [String: Any])
    case userInfo
}

extension UserService: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "http://13.124.238.120:8080")!
        }
    }

    var path: String {
        switch self {
        case .user:
            return "/user/psychology"
        case .userInfo:
            return "/user/info"
        }
    }

    var method: Moya.Method {
        switch self {
        case .user:
            return .post
        case .userInfo:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .user(param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .userInfo:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        print(UserDefaults.standard.value(forKey: "access_token"))
        return [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "access_token"))",
            "Content-Type": "application/json"
        ]
    }
}
