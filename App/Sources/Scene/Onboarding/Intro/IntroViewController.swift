//
//  IntroViewController.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class IntroViewController: UIViewController {
    private var disposeBag: DisposeBag = .init()
    private let introLogo = UIImageView().then {
        $0.image = UIImage(named: "PurpleLogo")
    }
    
    private let appTextLabel = UILabel().then {
        $0.text = "드러머"
        $0.textColor = AppAsset.mainColor.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 44)
    }
    
    private let appExplainTextLabel = UILabel().then {
        $0.text = "꿈을 꾸는 사람들을 위해"
        $0.textColor = AppAsset.gray5.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 24)
    }
    
    private let startButton = UIButton(type: .system).then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = AppAsset.mainColor.color
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.layer.cornerRadius = 8
    }
    
    private let alreadyHaveAccountLabel = UILabel().then {
        $0.text = "이미 계정이 있나요?"
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
    }
    
    private let loginButton = UnderLineButton(underLineColor: .mainColor ?? .purple).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(AppAsset.mainColor.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubviews()
        self.setLayout()

        startButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(NewUserViewController(), animated: true)
            }).disposed(by: disposeBag)
        loginButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(SignInViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
}

extension IntroViewController {
    private func addSubviews() {
        [
            introLogo,
            appTextLabel,
            appExplainTextLabel,
            startButton,
            alreadyHaveAccountLabel,
            loginButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        introLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(251)
            $0.centerX.equalToSuperview()
        }
        appTextLabel.snp.makeConstraints {
            $0.top.equalTo(introLogo.snp.bottom).offset(8)
            $0.centerX.equalTo(appTextLabel.snp.centerX)
        }
        appExplainTextLabel.snp.makeConstraints {
            $0.top.equalTo(appTextLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(appTextLabel.snp.centerX)
        }
        startButton.snp.makeConstraints {
            $0.top.equalTo(appExplainTextLabel.snp.bottom).offset(227)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
            $0.centerX.equalTo(appTextLabel.snp.centerX)
        }
        alreadyHaveAccountLabel.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(110)
        }
        loginButton.snp.makeConstraints {
            $0.centerY.equalTo(alreadyHaveAccountLabel.snp.centerY)
            $0.leading.equalTo(alreadyHaveAccountLabel.snp.trailing).offset(4)
        }
    }
}
