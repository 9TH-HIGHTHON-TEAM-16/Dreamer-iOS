import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class AuthenticationViewController: BaseViewController {
    private let titleLabel = UILabel().then {
        $0.text = "신원 확인을 위해 본인 인증을 진행해주세요."
        $0.font = AppFontFamily.Pretendard.bold.font(size: 24)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    private let sinBackView = UIView().then {
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor.gray2?.cgColor
        $0.layer.borderWidth = 1
    }
    private let sinTitleLabel = UILabel().then {
        $0.text = "주민등록번호"
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = AppAsset.gray6.color
    }
    private let birthTextField = UITextField().then {
        $0.placeholder = "240218"
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
        $0.keyboardType = .numberPad
    }
    private let hypenLabel = UILabel().then {
        $0.text = "  -  "
        $0.textColor = AppAsset.gray4.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
    }
    private let genderTextField = UITextField().then {
        $0.placeholder = "3"
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
        $0.keyboardType = .numberPad
    }
    private let asteriskLabel = UILabel().then {
        $0.text = "******"
        $0.textColor = AppAsset.gray4.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
    }
    private let nameTextFieldView = TitleTextFieldView().then {
        $0.title = "이름"
        $0.placeholder = "이름을 입력해주세요."
    }
    private let finishButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.medium.font(size: 18)
        $0.backgroundColor = AppAsset.gray4.color
        $0.layer.cornerRadius = 8
    }

    override func addView() {
        [
            sinTitleLabel,
            birthTextField,
            hypenLabel,
            genderTextField,
            asteriskLabel
        ].forEach {
            sinBackView.addSubview($0)
        }
        [
            titleLabel,
            sinBackView,
            nameTextFieldView,
            finishButton
        ].forEach {
            view.addSubview($0)
        }
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
        birthTextField.rx.text.orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { text in
                if text.count >= 6 {
                    self.birthTextField.text = String(text.prefix(6))
                    self.genderTextField.becomeFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        genderTextField.rx.text.orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { text in
                if text.count >= 1 {
                    self.genderTextField.text = String(text.prefix(1))
                    self.nameTextFieldView.textField.becomeFirstResponder()
                    self.finishButton.backgroundColor = AppAsset.mainColor.color
                }
            })
            .disposed(by: disposeBag)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(118)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(130)
        }
        sinBackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        sinTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(12)
        }
        birthTextField.snp.makeConstraints {
            $0.top.equalTo(sinTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(15)
        }
        hypenLabel.snp.makeConstraints {
            $0.centerY.equalTo(birthTextField.snp.centerY)
            $0.leading.equalTo(birthTextField.snp.trailing)
        }
        genderTextField.snp.makeConstraints {
            $0.centerY.equalTo(hypenLabel.snp.centerY)
            $0.leading.equalTo(hypenLabel.snp.trailing)
            $0.width.equalTo(11)
        }
        asteriskLabel.snp.makeConstraints {
            $0.centerY.equalTo(genderTextField.snp.centerY)
            $0.leading.equalTo(genderTextField.snp.trailing)
        }
        nameTextFieldView.snp.makeConstraints {
            $0.top.equalTo(sinBackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        finishButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(46)
        }
    }
}

extension AuthenticationViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        finishButton.snp.updateConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(20 + keyboardFrame.size.height)
            $0.height.equalTo(46)
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        finishButton.snp.updateConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(46)
        }
    }
}
