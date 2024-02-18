//
//  PolicyViewModel.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PolicyViewModel: BaseViewModel {
    private let policyList: PublishRelay<[PolicyListEntity]> = .init()
    
    struct Input {
        
    }
    
    struct Output {
        let policyList: Observable<[PolicyListEntity]>
    }
    
    func transform(input: Input) -> Output {
        return Output(policyList: policyList.asObservable())
    }
}

extension PolicyViewModel {
    func requestPolicyList() {
        NetworkManager.requestPolicyList() { (isSuccess, policyList) in
            guard isSuccess, let policyList = policyList else { return }
            self.policyList.accept(policyList)
        }
    }
}
