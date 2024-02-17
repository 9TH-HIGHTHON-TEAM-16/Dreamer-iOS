//
//  EmploymentTableVeiwCell.swift
//  App
//
//  Created by 선민재 on 2/17/24.
//

import UIKit
import SnapKit
import Then

final class EmploymentView: UIView {
    private let cellTitle = UILabel().then {
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.bold.font(size: 20)
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 147, height: 163)
    }
    
    private lazy var employmentCollectionView = UICollectionView().then {
        $0.collectionViewLayout = flowLayout
        $0.register(
            EmploymentCollectionViewCell.self,
            forCellWithReuseIdentifier: EmploymentCollectionViewCell.cellIdentifier
        )
    }
    
    init(title: String) {
        self.cellTitle.text = title
        super.init(frame: .zero)
        self.addSubviews()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmploymentView {
    private func addSubviews() {
        [
            cellTitle
//            employmentCollectionView
        ].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        cellTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
//        employmentCollectionView.snp.makeConstraints {
//            $0.top.equalTo(cellTitle.snp.bottom).offset(16)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
    }
}
