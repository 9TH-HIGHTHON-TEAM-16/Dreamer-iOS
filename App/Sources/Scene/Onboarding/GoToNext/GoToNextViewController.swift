import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class GoToNextViewController: BaseViewController {
    private let titleLabel = UILabel().then {
        $0.text = "드리머에 오신 것을 환영합니다!"
        $00.numberOfLines = 0
        $0.font = AppFontFamily.Pretendard.bold.font(size: 24)
        $0.textColor = AppAsset.black.color
    }
    private let highFiveImageView = UIImageView().then {
        $0.image = UIImage(named: "HighFive")
        $0.contentMode = .scaleAspectFit
    }
    private let goToNextButton = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.medium.font(size: 18)
        $0.backgroundColor = AppAsset.mainColor.color
        $0.layer.cornerRadius = 8
    }

    override func addView() {
        [
            titleLabel,
            highFiveImageView,
            goToNextButton
        ].forEach {
            self.view.addSubview($0)
        }
    }

    override func configureVC() {
        goToNextButton.rx.tap
            .subscribe(onNext: {
                let survey = TestViewController(with: TestViewModel())
                survey.modalPresentationStyle = .fullScreen
                self.present(survey, animated: true)
            }).disposed(by: disposeBag)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(118)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(160)
        }
        highFiveImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(-74)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        goToNextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(46)
        }
    }
}
