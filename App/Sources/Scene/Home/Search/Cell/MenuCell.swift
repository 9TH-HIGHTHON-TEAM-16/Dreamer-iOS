import UIKit
import Then
import SnapKit

class MenuCell: BaseTableViewCell {
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = AppAsset.gray6.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
    }
    override func addView() {
        addSubview(titleLabel)
    }
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
    }
}
