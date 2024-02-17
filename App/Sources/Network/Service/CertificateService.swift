//
//  CertificateService.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Moya
import Foundation

enum CertificateService {
    case certificateList
}

extension CertificateService: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "http://13.124.238.120:8080")!
        }
    }

    var path: String {
        switch self {
        case .certificateList:
            return "/certificate/list"
        }
    }

    var method: Moya.Method {
        switch self {
        case .certificateList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .certificateList:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
