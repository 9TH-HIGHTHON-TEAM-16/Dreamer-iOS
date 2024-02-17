//
//  UnderLineButton.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import SnapKit
import Then

final class UnderLineButton: UIButton {
    private let underLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(underLine)
        self.setLayout()
    }
    
    init(underLineColor: UIColor) {
        super.init(frame: .zero)
        self.addSubview(underLine)
        self.setLayout()
        self.underLine.backgroundColor = underLineColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UnderLineButton {
    private func setLayout() {
        underLine.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(1)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
    }
}
