import UIKit

public extension UITextField {
    func setHorizontalPadding(_ width: Double) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
}
