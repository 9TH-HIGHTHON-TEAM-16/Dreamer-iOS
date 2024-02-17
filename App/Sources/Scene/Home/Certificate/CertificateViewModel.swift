//
//  CertificateViewModel.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CertificateViewModel: BaseViewModel {
    private let certificateList: PublishRelay<[CertificateListEntity]> = .init()
    
    struct Input {
        
    }
    
    struct Output {
        let certificateList: Observable<[CertificateListEntity]>
    }
    
    func transform(input: Input) -> Output {
        return Output(certificateList: certificateList.asObservable())
    }
}

extension CertificateViewModel {
    func requestCertificateList() {
        NetworkManager.requestCertificateList() { (isSuccess, certificateList) in
            guard isSuccess, let certificateList = certificateList else { return }
            self.certificateList.accept(certificateList)
        }
    }
}
