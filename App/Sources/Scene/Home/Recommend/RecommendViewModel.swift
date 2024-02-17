//
//  RecommendViewModel.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class RecommendViewModel: BaseViewModel {
    private let jobList: PublishRelay<[JobListEntity]> = .init()
    
    struct Input {
        
    }
    
    struct Output {
        let jobList: Observable<[JobListEntity]>
    }
    
    func transform(input: Input) -> Output {
        return Output(jobList: jobList.asObservable())
    }
}

extension RecommendViewModel {
    func requestJobList(year: Int, role: String, location: String) {
        NetworkManager.requestJobList(year: year, role: role, location: location) { (isSuccess, jobList) in
            guard isSuccess, let jobList = jobList else { return }
            self.jobList.accept(jobList)
        }
    }
}
