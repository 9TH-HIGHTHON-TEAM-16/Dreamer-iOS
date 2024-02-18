//
//  TestViewController.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class TestViewController: UIViewController {
    private var disposeBag = DisposeBag()
    private var viewModel: TestViewModel
    private var index: Int = 0
    private var yes: Int = 0
    
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "BackButton"), for: .normal)
        $0.tintColor = AppAsset.black.color
    }
    
    private let questionValueLabel = UILabel().then {
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.bold.font(size: 24)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let yesButton = UIButton(type: .system).then {
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(AppAsset.gray7.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.backgroundColor = AppAsset.gray2.color
        $0.layer.cornerRadius = 8
    }
    
    private let noButton = UIButton(type: .system).then {
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(AppAsset.gray7.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.backgroundColor = AppAsset.gray2.color
        $0.layer.cornerRadius = 8
    }
    
    init(with viewModel: TestViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.bindAction()
        self.settingBaseQuestion()
        self.addSubViews()
        self.setLayout()
    }
    
    override var hidesBottomBarWhenPushed: Bool {
        get { return true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
}

extension TestViewController {
    private func bindAction() {
        backButton.rx.tap
            .withUnretained(self)
            .bind { (self,_)in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        yesButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.changeQuestion()
                self.yes = self.yes + 1
            }
            .disposed(by: disposeBag)
        
        noButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.changeQuestion()
            }
            .disposed(by: disposeBag)
    }
    
    private func changeQuestion() {
        guard index != viewModel.questionList.count else {
            let vc = CompletedViewController()
            self.navigationController?.setViewControllers([vc], animated: true)
            return
        }
        
        questionValueLabel.text = viewModel.questionList[index]
        index = index + 1
    }
}

extension TestViewController {
    private func settingBaseQuestion() {
        questionValueLabel.text = viewModel.questionList.first
    }
    
    private func addSubViews() {
        [
            backButton,
            questionValueLabel,
            yesButton,
            noButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
        }
        questionValueLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(26)
        }
        yesButton.snp.makeConstraints {
            $0.top.equalTo(questionValueLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
        noButton.snp.makeConstraints {
            $0.top.equalTo(yesButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
}
