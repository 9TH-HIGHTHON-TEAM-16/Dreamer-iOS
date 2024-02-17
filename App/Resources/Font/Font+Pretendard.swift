import UIKit

public extension UIFont {
    // swiftlint:disable identifier_name
    enum FontSystem: Fontable {
        case bold(size: CGFloat)
        case semibold(size: CGFloat)
        case medium(size: CGFloat)
    }
    // swiftlint:enable identifier_name

    static func pretendard(_ style: FontSystem, _ size: CGFloat) -> UIFont {
        return style.font
    }
}

public extension UIFont.FontSystem {
    var font: UIFont {
        switch self {
        case .bold(let size):
            return UIFont(name: "Pretendard-Bold.otf", size: size) ?? .init()
        case .semibold(let size):
            return UIFont(name: "Pretendard-Medium.otf", size: size) ?? .init()
        case .medium(let size):
            return UIFont(name: "Pretendard-Semibold.otf", size: size) ?? .init()
        }
    }
}
