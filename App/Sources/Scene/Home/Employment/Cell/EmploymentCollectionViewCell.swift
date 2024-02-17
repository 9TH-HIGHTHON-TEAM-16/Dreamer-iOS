//
//  EmploymentCollectionViewCell.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import SnapKit
import Then

final class EmploymentCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "employmentCollectionViewCell"
    
    let employmentImage = UIImageView().then {
        $0.layer.cornerRadius = 8
    }
    
    let employmentTitle = UILabel().then {
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 20)
        $0.textAlignment = .left
    }
    
    let employmentSubTitle = UILabel().then {
        $0.textColor = AppAsset.gray4.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmploymentCollectionViewCell {
    private func addSubviews() {
        [
            employmentImage,
            employmentTitle,
            employmentSubTitle
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
        employmentImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(147)
            $0.height.equalTo(110)
        }
        employmentTitle.snp.makeConstraints {
            $0.top.equalTo(employmentImage.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        employmentSubTitle.snp.makeConstraints {
            $0.top.equalTo(employmentTitle.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
    }
}
