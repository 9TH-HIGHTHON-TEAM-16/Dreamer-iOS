//
//  TabBarViewController.swift
//  App
//
//  Created by 선민재 on 2/18/24.
//

import UIKit
import RxSwift
import RxCocoa

final class MainTabBarController: UITabBarController {
    enum TabBarItem: Int, CaseIterable {
        case employment
        case recommend
        case certificate
        case policy
        case myPage
        
        var title: String {
            switch self {
            case .employment:
                return "채용"
            case .recommend:
                return "직업 추천"
            case .certificate:
                return "자격증"
            case .policy:
                return "관련 제도"
            case .myPage:
                return "마이"
            }
        }
        
        var tabImage: UIImage {
            switch self {
            case .employment:
                return UIImage(named: "Employment")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .recommend:
                return UIImage(named: "Recommend")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .certificate:
                return UIImage(named: "Certificate")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .policy:
                return UIImage(named: "Policy")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .myPage:
                return UIImage(named: "MyPage")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            }
        }
        
        var selectedTabImage: UIImage {
            switch self {
            case .employment:
                return UIImage(named: "EmploymentSelected")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .recommend:
                return UIImage(named: "RecommendSelected")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .certificate:
                return UIImage(named: "CertificateSelected")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .policy:
                return UIImage(named: "PolicySelected")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            case .myPage:
                return UIImage(named: "MyPageSelected")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
            }
        }
        
        var navigationController: UINavigationController {
            switch self {
            case .employment:
                let viewModel = HomeViewModel()
                return UINavigationController(rootViewController: HomeViewController(with: viewModel))
            case .recommend:
                let viewModel = HomeViewModel()
                return UINavigationController(rootViewController: HomeViewController(with: viewModel))
            case .certificate:
                let viewModel = CertificateViewModel()
                return UINavigationController(rootViewController: CertificateViewController(with: viewModel))
            case .policy:
                let viewModel = PolicyViewModel()
                return UINavigationController(rootViewController: PolicyViewController(with: viewModel))
            case .myPage:
                let viewModel = MyPageViewModel()
                return UINavigationController(rootViewController: MyPageViewController(with: viewModel))
            }
        }
    }
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = AppAsset.mainColor.color
        self.tabBar.unselectedItemTintColor = AppAsset.gray5.color
        self.configureTab()
    }
    
    private func configureTab() {
        var viewControllers = [UINavigationController]()

        for item in TabBarItem.allCases {
            let navigationController = item.navigationController
            navigationController.tabBarItem = UITabBarItem(
                title: item.title,
                image: item.tabImage,
                selectedImage: item.selectedTabImage
            )
            viewControllers.append(navigationController)
        }
        self.viewControllers = viewControllers
    }
}
