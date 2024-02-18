//
//  MyPageViewModel.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class MyPageViewModel: BaseViewModel {
    private let userInfo: PublishRelay<UserInfoEntity> = .init()
    
    struct Input {
    }
    
    struct Output {
        let userInfo: Observable<UserInfoEntity>
    }
    
    func transform(input: Input) -> Output {
        return Output(userInfo: userInfo.asObservable())
    }
}

extension MyPageViewModel {
    func requestUserInfo() {
        NetworkManager.requestUserInfo() { (isSuccess, userInfo) in
            guard isSuccess, let userInfo = userInfo else { return }
            self.userInfo.accept(userInfo)
        }
    }
}
