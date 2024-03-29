//
//  PolicyViewController.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

final class PolicyViewController: UIViewController {
    private let navigationBar = HomeNavigationBar(navigationBarTitle: "관련제도")
    private var viewModel: PolicyViewModel
    private var disposeBag = DisposeBag()

    private let firstView = EmploymentView(title: "국민취업지원제도")
    private let secondView = EmploymentView(title: "자격증")
    private let thirdView = EmploymentView(title: "창업지원제도")
    
    init(with viewModel: PolicyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.viewModel.requestPolicyList()
        self.bindViewModel()
        self.addSubviews()
        self.setLayout()
    }
}

extension PolicyViewController {
    private func bindViewModel() {
        let input = PolicyViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.policyList
            .bind(to: firstView.employmentCollectionView.rx.items(
                cellIdentifier: EmploymentCollectionViewCell.cellIdentifier,
                cellType: EmploymentCollectionViewCell.self
            )) { (ip, item, cell)  in
                
                cell.employmentImage.kf.setImage(
                    with: URL(string: item.urls.first ?? ""),
                    placeholder: UIImage(named: "DummyImage")
                )
                
                cell.employmentTitle.text = item.title
                cell.employmentSubTitle.text = item.content
            }
            .disposed(by: disposeBag)
        
        output.policyList
            .bind(to: secondView.employmentCollectionView.rx.items(
                cellIdentifier: EmploymentCollectionViewCell.cellIdentifier,
                cellType: EmploymentCollectionViewCell.self
            )) { (ip, item, cell)  in
                
                cell.employmentImage.kf.setImage(
                    with: URL(string: item.urls.first ?? ""),
                    placeholder: UIImage(named: "DummyImage")
                )
                
                cell.employmentTitle.text = item.title
                cell.employmentSubTitle.text = item.content
            }
            .disposed(by: disposeBag)
    }
}

extension PolicyViewController {
    private func addSubviews() {
        [
            navigationBar,
            firstView,
            secondView,
            thirdView
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
            $0.height.equalTo(220)
            $0.leading.trailing.equalToSuperview()
        }
        secondView.snp.makeConstraints {
            $0.top.equalTo(firstView.snp.bottom).offset(24)
            $0.height.equalTo(220)
            $0.leading.trailing.equalToSuperview()
        }
        thirdView.snp.makeConstraints {
            $0.top.equalTo(secondView.snp.bottom).offset(24)
            $0.height.equalTo(220)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

