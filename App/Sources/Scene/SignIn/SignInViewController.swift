import UIKit
import SnapKit
import Then
import Alamofire

class SignInViewController: BaseViewController {
    private let titleLabel = UILabel().then {
        $0.text = "드리머에 돌아오신 것을 생성해주세요."
        $0.font = AppFontFamily.Pretendard.bold.font(size: 24)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    private let emailTextFieldView = TitleTextFieldView().then {
        $0.title = "이메일"
        $0.placeholder = "highthon@gmail.com"
    }
    private let pwTextFieldView = TitleTextFieldView().then {
        $0.title = "비밀번호"
        $0.placeholder = "비밀번호를 입력해주세요."
    }
    private let exclamationImageView = UIImageView().then {
        $0.image = UIImage(named: "ExclamationMark")
        $0.contentMode = .scaleAspectFit
    }
    private let noticeTextLabel = UILabel().then {
        $0.text = "비밀번호는 최소 8자 이상이어야 합니다."
        $0.textColor = AppAsset.gray4.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 14)
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
            titleLabel,
            emailTextFieldView,
            pwTextFieldView,
            noticeTextLabel,
            exclamationImageView,
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

        pwTextFieldView.textField.rx.text.orEmpty
            .subscribe(onNext: { [self] text in
                if !text.isEmpty {
                    finishButton.backgroundColor = AppAsset.mainColor.color
                }
            }).disposed(by: disposeBag)

        finishButton.rx.tap
            .subscribe(onNext: { [self] in
                let url = "http://13.124.238.120:8080/auth/sign-in"
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                // POST 로 보낼 정보
                let params: Parameters = [
                    "email": emailTextFieldView.textField.text!,
                    "password": pwTextFieldView.textField.text!
                ]
                
                // httpBody 에 parameters 추가
                do {
                    try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                } catch {
                    print("http Body Error")
                }
                
                
                AF.request(request).response { (response) in
                    switch response.result {
                    case .success:
                        if let data = try? JSONDecoder().decode(SignInModel.self, from: response.data!){
                            DispatchQueue.main.async {
                                debugPrint(response)
                                UserDefaults.standard.set(data.data.accessToken, forKey: "access_token")
                                let next = HomeViewController(with: HomeViewModel())
                                next.modalPresentationStyle = .fullScreen
                                self.present(next, animated: true)
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }).disposed(by: disposeBag)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(118)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(160)
        }
        emailTextFieldView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        pwTextFieldView.snp.makeConstraints {
            $0.top.equalTo(emailTextFieldView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        noticeTextLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextFieldView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(40)
        }
        exclamationImageView.snp.makeConstraints {
            $0.trailing.equalTo(noticeTextLabel.snp.leading).offset(-4)
            $0.width.height.equalTo(12)
            $0.centerY.equalTo(noticeTextLabel.snp.centerY)
        }
        finishButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(63)
            $0.height.equalTo(46)
        }
    }
}

extension SignInViewController {
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
