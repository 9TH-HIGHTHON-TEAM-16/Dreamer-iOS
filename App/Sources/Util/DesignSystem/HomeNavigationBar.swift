//
//  HomeNavigationBar.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import SnapKit
import Then

final class HomeNavigationBar: UIView {
    private let navigationBarTitleLabel = UILabel().then {
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 24)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(navigationBarTitleLabel)
        self.setLayout()
    }
    
    init(navigationBarTitle: String) {
        super.init(frame: .zero)
        self.navigationBarTitleLabel.text = navigationBarTitle
        self.addSubview(navigationBarTitleLabel)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeNavigationBar {
    private func setLayout() {
        navigationBarTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
