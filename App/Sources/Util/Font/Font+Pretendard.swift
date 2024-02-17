import UIKit

public extension UIFont {
    enum FontSystem: Fontable {
        case bold(size: CGFloat)
        case semibold(size: CGFloat)
        case medium(size: CGFloat)
    }

    static func pretendard(_ style: FontSystem) -> UIFont {
        return style.font
    }
}

public extension UIFont.FontSystem {
    var font: UIFont {
        switch self {
        case .bold(let size):
            return UIFont(name: "Pretendard-Bold", size: size) ?? .init()
        case .semibold(let size):
            return UIFont(name: "Pretendard-Medium", size: size) ?? .init()
        case .medium(let size):
            return UIFont(name: "Pretendard-Semibold", size: size) ?? .init()
        }
    }
}
