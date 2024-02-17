//
//  DetailViewController.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

final class DetailViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let image = UIImageView()
    
    private let contentTitle = UILabel().then {
        $0.text = "[200억↑투자] PD팀 Lead (Product designer)"
        $0.textColor = AppAsset.grayScale.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 24)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let contentSubTitle = UILabel().then {
        $0.text = "핏펫(Fitpet)∙서울 강남구∙경력 8-15년"
        $0.textColor = AppAsset.gray4.color
        $0.numberOfLines = 0
        $0.font = AppFontFamily.Pretendard.medium.font(size: 18)
        $0.textAlignment = .left
    }
    
    private let significantTitleLabel = UILabel().then {
        $0.text = "👥 특이사항"
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 18)
        $0.textAlignment = .left
    }
    
    private let significantSubLabel = UILabel().then {
        $0.text = "👥 특이사항"
        $0.textColor = AppAsset.gray6.color
        $0.numberOfLines = 0
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .left
    }
    
    private let detailTitleText = UILabel().then {
        $0.text = "포지션 세부정보"
        $0.textColor = AppAsset.black.color
        $0.font = AppFontFamily.Pretendard.semiBold.font(size: 18)
        $0.textAlignment = .left
    }
    
    private let detailContentText = UILabel().then {
        $0.text = "포지션 세부정보"
        $0.textColor = AppAsset.gray6.color
        $0.font = AppFontFamily.Pretendard.medium.font(size: 14)
        $0.textAlignment = .left
    }
    
    private let detailButton = UIButton().then {
        $0.setTitle("상세 정보 더 보기", for: .normal)
        $0.setTitleColor(AppAsset.black.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 14)
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = AppAsset.gray4.color.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .clear
    }
    
    private let applyButton = UIButton().then {
        $0.setTitle("지원하기", for: .normal)
        $0.setTitleColor(AppAsset.white.color, for: .normal)
        $0.titleLabel?.font = AppFontFamily.Pretendard.semiBold.font(size: 16)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = AppAsset.mainColor.color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.setLayout()
    }
}

extension DetailViewController {
    private func addSubView() {
        [
            image,
            contentTitle,
            contentSubTitle,
            significantTitleLabel,
            significantSubLabel,
            detailTitleText,
            detailContentText,
            detailButton,
            applyButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        image.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        contentTitle.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        contentSubTitle.snp.makeConstraints {
            $0.top.equalTo(contentTitle.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        significantTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentSubTitle.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        significantSubLabel.snp.makeConstraints {
            $0.top.equalTo(contentSubTitle.snp.bottom).offset(24)
            $0.leading.equalTo(significantTitleLabel.snp.trailing).offset(12)
        }
        detailTitleText.snp.makeConstraints {
            $0.top.equalTo(significantSubLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        detailContentText.snp.makeConstraints {
            $0.top.equalTo(detailTitleText.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        detailButton.snp.makeConstraints {
            $0.top.equalTo(detailContentText.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        applyButton.snp.makeConstraints {
            $0.top.equalTo(detailButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(46)
        }
    }
}
