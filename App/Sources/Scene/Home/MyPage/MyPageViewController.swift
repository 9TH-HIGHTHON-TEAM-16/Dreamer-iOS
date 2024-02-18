//
//  MyPageViewController.swift
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

final class MyPageViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private let navigationBar = HomeNavigationBar(navigationBarTitle: "마이")
    private let viewModel: MyPageViewModel
    private var text1: String = ""
    private var text2: String = ""
    
    private let userNameLabel = UILabel().then {
        $0.text = "Highton"
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 24)
    }
    
    private let userJob = UILabel().then {
        $0.text = "Highton"
        $0.textColor = AppAsset.gray4.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 14)
    }
    
    private let userImage = UIImageView().then {
        $0.image = UIImage(named: "DummyProfile")
    }
    
    private let settingButton = UIButton().then {
        $0.setTitle("설정", for: .normal)
        $0.setTitleColor(AppAsset.gray7.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.backgroundColor = AppAsset.gray2.color
        $0.layer.cornerRadius = 8
    }
    
    private let showTestResultButton = UIButton().then {
        $0.setTitle("직업 심리 검사 다시보기", for: .normal)
        $0.setTitleColor(AppAsset.gray7.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.backgroundColor = AppAsset.gray2.color
        $0.layer.cornerRadius = 8
    }
    
    init(with viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.viewModel.requestUserInfo()
        self.bindAction()
        self.addSubviews()
        self.setLayout()
    }
}

extension MyPageViewController {
    private func bindAction() {
        showTestResultButton.rx.tap
            .bind {
                let vc = TestResultViewController(psychology: self.text1, type: self.text2)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        let input = MyPageViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.userInfo
            .withUnretained(self)
            .bind { (self, userInfo) in
                self.userNameLabel.text = userInfo.name
                self.text1 = userInfo.psychology
                self.text2 = userInfo.type
            }
            .disposed(by: disposeBag)
        
    }
}

extension MyPageViewController {
    private func addSubviews() {
        [
            navigationBar,
            userImage,
            userNameLabel,
            userJob,
            settingButton,
            showTestResultButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        userImage.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(29)
            $0.leading.equalTo(userImage.snp.trailing).offset(12)
        }
        userJob.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(userImage.snp.trailing).offset(12)
        }
        settingButton.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        showTestResultButton.snp.makeConstraints {
            $0.top.equalTo(settingButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
}
