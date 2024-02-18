//
//  PolicyService.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Moya
import Foundation

enum PolicyService {
    case policyList
}

extension PolicyService: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "http://13.124.238.120:8080")!
        }
    }

    var path: String {
        switch self {
        case .policyList:
            return "/policy/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .policyList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .policyList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
