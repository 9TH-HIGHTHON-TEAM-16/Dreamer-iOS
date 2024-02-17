//
//  Network.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation
import Moya

final class NetworkManager {
    static func requestJobList(
        year: Int,
        role: String,
        location: String,
        completionHandler: @escaping (Bool, [JobListEntity]?) -> Void
    ) {
        let param: [String: Any] = ["year": year, "role": role, "location": location]
        
        MoyaProvider<JobService>().request(.jobList(param: param)) { result in
            switch result {
            case let .success(response):
                do {
                    let _ = try response.filterSuccessfulStatusCodes()
                    
                    let responseDTO = try response.map(DefaultResponseDTO<[JobListResponseDTO]>.self, using: JSONDecoder())
                    
                    completionHandler(true, responseDTO.data.map { $0.toDomain })
                }
                catch(let error) {
                    print("ERROR \(error)")
                }
            case let .failure(error):
                print("error is \(error.localizedDescription)")
                completionHandler(false, nil)
            }
        }
    }
    
    static func requestPolicyList(
        completionHandler: @escaping (Bool, [PolicyListEntity]?) -> Void
    ) {
        
        MoyaProvider<PolicyService>().request(.policyList) { result in
            switch result {
            case let .success(response):
                do {
                    let _ = try response.filterSuccessfulStatusCodes()
                    
                    let responseDTO = try response.map(DefaultResponseDTO<[PolicyListResponseDTO]>.self, using: JSONDecoder())
                    
                    completionHandler(true, responseDTO.data.map { $0.toDomain })
                }
                catch(let error) {
                    print("ERROR \(error)")
                }
            case let .failure(error):
                print("error is \(error.localizedDescription)")
                completionHandler(false, nil)
            }
        }
    }
    
    static func requestCertificateList(completionHandler: @escaping (Bool, [CertificateListEntity]?) -> Void) { 
        MoyaProvider<CertificateService>().request(.certificateList) { result in
            switch result {
            case let .success(response):
                do {
                    let _ = try response.filterSuccessfulStatusCodes()
                    
                    let responseDTO = try response.map(DefaultResponseDTO<[CertificateListResponseDTO]>.self, using: JSONDecoder())
                    
                    completionHandler(true, responseDTO.data.map { $0.toDomain })
                }
                catch(let error) {
                    print("ERROR \(error)")
                }
            case let .failure(error):
                print("error is \(error.localizedDescription)")
                completionHandler(false, nil)
            }
        }
    }
}
