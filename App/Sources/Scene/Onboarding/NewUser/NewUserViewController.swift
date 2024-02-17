import UIKit
import SnapKit
import Then

class NewUserViewController: BaseViewController {
    private let titleLabel = UILabel().then {
        $0.text = "드리머에서 사용할 계정을 생성해주세요."
//        $0.font = .pretendard(.bold(size: 24))
        $0.textColor = .black
    }

    override func addView() {
        [
            titleLabel
        ].forEach {
            view.addSubview($0)
        }
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
