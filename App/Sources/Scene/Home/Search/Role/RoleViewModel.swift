import Foundation
import RxSwift
import RxCocoa

class RoleViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let test: PublishRelay<[String]> = .init()
    private let test2: PublishRelay<[String]> = .init()
    struct Input {
//        let selectedIndex: Signal<IndexPath>
//        let isPostion: Bool
        let didTapA: ControlEvent<Void>
        let didTapB: ControlEvent<Void>
    }
    struct Output {
        let resultA: Observable<[String]>
        let resultB: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        let res = BehaviorRelay<String>(value: "")
        
//        if input.isPostion {
//            input.selectedIndex.asObservable()
//                .subscribe(onNext: { index in
//                    let pos = ["개발자", "디자이너", "기획자", "채용 담당자"]
//                    res.accept(pos[index.row])
//                }).disposed(by: disposeBag)
//        } else {
//            input.selectedIndex.asObservable()
//                .subscribe(onNext: { index in
//                    let work = ["iOS 개발", "안드로이드 개발", "게임 개발", "HR", "서버 개발"]
//                    res.accept(work[index.row])
//                }).disposed(by: disposeBag)
//        }
        
        input.didTapA
            .subscribe(onNext: {
                let pos = ["개발자", "디자이너", "기획자", "채용 담당자"]
                self.test.accept(pos)
            })
            .disposed(by: disposeBag)
        
        input.didTapB
            .subscribe(onNext: {
                let pos = ["iOS 개발", "안드로이드 개발", "게임 개발", "HR", "서버 개발"]
                self.test2.accept(pos)
            })
            .disposed(by: disposeBag)

        return Output(
            resultA: test.asObservable(),
            resultB: test2.asObservable()
        )
    }
}
