//
//  CertificateViewController.swift
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

final class CertificateViewController: UIViewController {
    private let navigationBar = HomeNavigationBar(navigationBarTitle: "채용")
    private var viewModel: CertificateViewModel
    private var disposeBag = DisposeBag()

    private let firstView = EmploymentView(title: "요즘 인기가 많아요.")
    private let secondView = EmploymentView(title: "쉽게 취득할 수 있어요.")
    private let thirdView = EmploymentView(title: "자격증 취득 지원이 있어요.")
    
    init(with viewModel: CertificateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.viewModel.requestCertificateList()
        self.bindViewModel()
        self.addSubviews()
        self.setLayout()
    }
}

extension CertificateViewController {
    private func bindViewModel() {
        let input = CertificateViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.certificateList
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
        
        output.certificateList
            .bind(to: secondView.employmentCollectionView.rx.items(
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
        
        output.certificateList
            .bind(to: thirdView.employmentCollectionView.rx.items(
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

extension CertificateViewController {
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
            $0.leading.trailing.equalToSuperview()
        }
        secondView.snp.makeConstraints {
            $0.top.equalTo(firstView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        thirdView.snp.makeConstraints {
            $0.top.equalTo(secondView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

