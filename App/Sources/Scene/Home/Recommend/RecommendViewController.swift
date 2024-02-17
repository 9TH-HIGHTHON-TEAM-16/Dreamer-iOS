//
//  RecommendViewController.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

final class RecommendViewController: UIViewController {
    private let navigationBar = HomeNavigationBar(navigationBarTitle: "채용")
    private var viewModel: HomeViewModel
    private var disposeBag = DisposeBag()

    private let firstView = EmploymentView(title: "성향에 딱 맞는 직업이에요.")
    private let secondView = EmploymentView(title: "비슷한 나이대의 지원자들이 많이 지원했어요.")
    private let thirdView = EmploymentView(title: "누구나 입문하기 쉬워요.")
    
    init(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.bindViewModel()
        self.addSubviews()
        self.setLayout()
    }
}

extension RecommendViewController {
    private func bindViewModel() {
        let input = HomeViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.jobList
            .bind(to: firstView.employmentCollectionView.rx.items(
                cellIdentifier: EmploymentCollectionViewCell.cellIdentifier,
                cellType: EmploymentCollectionViewCell.self
            )) { (ip, item, cell)  in
                let url = URL(string: item.urls[ip])
                
                cell.employmentImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "DummyImage")
                )
                
                cell.employmentTitle.text = item.title
                cell.employmentSubTitle.text = item.content
            }
            .disposed(by: disposeBag)
        
    }
}

extension RecommendViewController {
    private func addSubviews() {
        [
            navigationBar,
            filterCollectionView,
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
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        firstView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        secondView.snp.makeConstraints {
            $0.top.equalTo(firstView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

