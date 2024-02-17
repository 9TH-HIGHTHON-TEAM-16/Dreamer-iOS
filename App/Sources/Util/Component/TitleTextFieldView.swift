import UIKit
import SnapKit
import Then

class TitleTextFieldView: UIView {
    public var title: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }
    public var placeholder: String {
        get { textField.placeholder ?? "" }
        set { textField.placeholder = newValue }
    }

    private let label = UILabel().then {
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textColor = AppAsset.gray6.color
    }
    public let textField = UITextField().then {
        $0.font = AppFontFamily.Pretendard.medium.font(size: 16)
        $0.textColor = AppAsset.black.color
    }

    public init() {
        super.init(frame: .zero)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {
        self.layer.cornerRadius = 4
        self.layer.borderColor = AppAsset.gray2.color.cgColor
        self.layer.borderWidth = 1
        
//        self.snp.makeConstraints {
//            $0.height.equalTo(68)
//        }

        [
            label,
            textField
        ].forEach {
            self.addSubview($0)
        }

        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(12)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}
