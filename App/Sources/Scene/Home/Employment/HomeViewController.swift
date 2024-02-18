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
import Kingfisher

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
    
    private let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 163, height: 32)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            EmploymentCollectionViewCell.self,
            forCellWithReuseIdentifier: EmploymentCollectionViewCell.cellIdentifier
        )
        return collectionView
    }()

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
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.viewModel.requestJobList(year: 1, role: "개발자", location: "서울특별시")
        self.bindViewModel()
        self.filterCollectionView.dataSource = self
        self.addSubviews()
        self.setLayout()
    }
}

extension HomeViewController {
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
        
        output.jobList
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
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmploymentCollectionViewCell.cellIdentifier, for: indexPath) as? EmploymentCollectionViewCell else { return UICollectionViewCell() }
//        cell.employmentTitle.text = "지역"
//        cell.employmentSubTitle.text = "서울특별시"
//        
        return cell
    }
}

extension HomeViewController {
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
            $0.height.equalTo(220)
            $0.leading.trailing.equalToSuperview()
        }
        secondView.snp.makeConstraints {
            $0.top.equalTo(firstView.snp.bottom).offset(24)
            $0.height.equalTo(220)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
