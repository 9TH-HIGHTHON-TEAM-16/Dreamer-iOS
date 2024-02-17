//
//  HomeViewController.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

enum ViewType {
    case employment
    case recommend
    case certificate
    case policy
}

final class HomeViewController: UIViewController {
    private let navigationBar = HomeNavigationBar(navigationBarTitle: "채용")
    private var viewModel: HomeViewModel
    private var disposeBag = DisposeBag()

    private let firstView = EmploymentView(title: "신입도 지원이 가능해요")
    private let secondView = EmploymentView(title: "자격증 없어도 괜찮아요")
    
    init(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        self.bindViewModel()
        self.viewModel.requestJobList(year: 1, role: "개발자", location: "서울특별시")
        self.addSubviews()
        self.setLayout()
    }
}

extension HomeViewController {
    private func bindViewModel() {
        let input = HomeViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.jobList
            .withUnretained(self)
            .bind { jobList in
                print(jobList)
            }
            .disposed(by: disposeBag)
        
    }
}

extension HomeViewController {
    private func addSubviews() {
        [
            navigationBar,
            firstView,
            secondView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        firstView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        secondView.snp.makeConstraints {
            $0.top.equalTo(firstView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
