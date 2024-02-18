//
//  TestResultViewController.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class TestResultViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let resultTitle = UILabel().then {
        $0.text = "Highton님은 \nR 유형입니다."
        $0.numberOfLines = 2
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.bold.font(size: 24)
        $0.textAlignment = .left
    }
    
    private let resultImage = UIImageView().then {
        $0.image = UIImage(named: "TestResult")
    }
    
    private let resultText = UILabel().then {
        $0.text = "R 유형"
        $0.textColor = AppAsset.gray7.color
        $0.font = AppFontFamily.Pretendard.bold.font(size: 22)
        $0.textAlignment = .left
    }
    
    private let resulExplainText = UILabel().then {
        $0.text = "R 유형은 실재형 진로발달 유형입니다. 성격 특성 직접 느끼 움직이는 체험을 중요시 합니다. 손이나 도구를 사용하는 조작을 즐겨합니다. 대표 직업은 경찰관, 동물 조련사, 요리사 등이 있습니다."
        $0.textColor = AppAsset.gray4.color
        $0.numberOfLines = 0
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .left
    }
    
    private let reusltExplainButton = UIButton().then {
        $0.setTitle("직업 심리 검사 다시하기", for: .normal)
        $0.setTitleColor(AppAsset.white.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.backgroundColor = AppAsset.mainColor.color
        $0.layer.cornerRadius = 8
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "BackButton"), for: .normal)
    }
    
    init(psychology: String, type: String) {
        super.init(nibName: nil, bundle: nil)
        self.resulExplainText.text = psychology
        self.resultText.text = "\(type) 유형"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.bindAction()
        self.addSubviews()
        self.setLayout()
    }
    
    override var hidesBottomBarWhenPushed: Bool {
        get { return true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
}

extension TestResultViewController {
    private func bindAction() {
        backButton.rx.tap
            .withUnretained(self)
            .bind { (self,_)in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        reusltExplainButton.rx.tap
            .withUnretained(self)
            .bind { (self, _ ) in
                let viewModel = TestViewModel()
                let vc = TestViewController(with: viewModel)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension TestResultViewController {
    private func addSubviews() {
        [
            backButton,
            resultTitle,
            resultImage,
            resultText,
            resulExplainText,
            reusltExplainButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
        }
        
        resultTitle.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        resultImage.snp.makeConstraints {
            $0.top.equalTo(resultTitle.snp.bottom).offset(42)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(220)
        }
        
        resultText.snp.makeConstraints {
            $0.top.equalTo(resultImage.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        resulExplainText.snp.makeConstraints {
            $0.top.equalTo(resultText.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        reusltExplainButton.snp.makeConstraints {
            $0.top.equalTo(resulExplainText.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
}
