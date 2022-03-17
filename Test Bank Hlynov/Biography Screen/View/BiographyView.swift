import UIKit

final class BiographyView: SearchView {
    required init(goBackButtonAction: @escaping () -> Void, responseView: ResponseView) {
        super.init(goBackButtonAction: goBackButtonAction, responseView: responseView)
        self.setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        titleLabel.text = NSLocalizedString("Биография", comment: "")
    }
}
