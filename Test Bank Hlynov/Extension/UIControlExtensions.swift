import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> Void) {
        self.addAction(UIAction { (_: UIAction) in closure() }, for: controlEvents)
    }
}
