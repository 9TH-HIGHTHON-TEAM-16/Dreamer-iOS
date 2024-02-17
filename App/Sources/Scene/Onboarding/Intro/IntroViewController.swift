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
    private let introLogo = UIImageView().then {
        $0.image = UIImage(named: "PurpleLogo")
    }
    
    private let appTextLabel = UILabel().then {
        $0.text = "드러머"
        $0.textColor = .mainColor
        $0.font = .pretendard(.semibold(size: 44))
    }
    
    private let appExplainTextLabel = UILabel().then {
        $0.text = "꿈을 꾸는 사람들을 위해"
        $0.textColor = .gray5
        $0.font = .pretendard(.medium(size: 24))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setLayout()
    }
}

extension IntroViewController {
    private func addSubviews() {
        [
            introLogo,
            appTextLabel,
            appExplainTextLabel
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
    }
}
