//
//  HomeFilterCell.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import UIKit
import SnapKit
import Then

final class HomeFilterCell: UICollectionViewCell {
    static let cellIdentifier = "homeFilterCell"
    
    let filterTitle = UILabel().then {
        $0.textColor = AppAsset.gray5.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.sizeToFit()
    }
    
    let filterValue = UILabel().then {
        $0.textColor = AppAsset.mainColor.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .center
    }
    
    private let downArrowImageView = UIImageView().then {
        $0.image = UIImage(named: "downArrow")
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

extension HomeFilterCell {
    private func addSubviews() {
        [
            filterTitle,
            downArrowImageView,
            filterValue
        ].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        filterTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        downArrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(filterTitle.snp.centerY)
            $0.leading.equalTo(filterValue.snp.trailing).offset(4)
        }
        filterValue.snp.makeConstraints {
            $0.centerY.equalTo(filterTitle.snp.centerY)
            $0.leading.equalTo(filterTitle.snp.trailing).offset(8)
            $0.trailing.equalTo(downArrowImageView.snp.leading).offset(4)
        }
    }
}
