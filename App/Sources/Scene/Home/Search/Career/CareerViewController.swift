import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class CareerViewController: BaseViewController {
    private let navigationTitleLabel = UILabel().then {
        $0.text = "경력"
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 17)
        $0.textColor = AppAsset.gray8.color
    }
    private let restartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "restart"), for: .normal)
        $0.tintColor = AppAsset.gray4.color
    }
    private let closeButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "close"), for: .normal)
        $0.tintColor = AppAsset.gray4.color
    }
    private let periodLabel = UILabel().then {
        $0.text = "경력 기간"
        $0.font = AppFontFamily.Pretendard.medium.font(size: 18)
        $0.textColor = .black
    }
    private let periodTextField = UITextField().then {
        $0.placeholder = "경력 기간(년)을 입력해주세요."
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
        $0.textColor = AppAsset.mainColor.color
        $0.setHorizontalPadding(8)
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = AppAsset.gray4.color.cgColor
        $0.layer.borderWidth = 1
    }
    private let confirmButton = UIButton(type: .system).then {
        $0.setTitle("확인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.medium.font(size: 18)
        $0.backgroundColor = AppAsset.mainColor.color
        $0.layer.cornerRadius = 8
    }

    override func addView() {
        [
            navigationTitleLabel,
            restartButton,
            closeButton,
            periodLabel,
            periodTextField,
            confirmButton
        ].forEach { view.addSubview($0) }
    }

    override func configureVC() {
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        closeButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        confirmButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }

    override func setLayout() {
        navigationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(70)
            $0.centerX.equalToSuperview()
        }
        restartButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel.snp.centerY)
            $0.width.height.equalTo(17)
            $0.leading.equalToSuperview().inset(20)
        }
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(navigationTitleLabel.snp.centerY)
            $0.width.height.equalTo(17)
            $0.trailing.equalToSuperview().inset(20)
        }
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
        }
        periodTextField.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(periodLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        confirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(46)
        }
    }
}

extension CareerViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        confirmButton.snp.updateConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20 + keyboardFrame.size.height)
            $0.height.equalTo(46)
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        confirmButton.snp.updateConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(46)
        }
    }
}
