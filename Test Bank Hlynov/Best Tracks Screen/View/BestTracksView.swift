import UIKit

final class BestTracksView: SearchView {
    required init(goBackButtonAction: @escaping () -> Void, responseView: ResponseView) {
        super.init(goBackButtonAction: goBackButtonAction, responseView: responseView)
        self.setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.85
        titleLabel.attributedText = NSMutableAttributedString(string: NSLocalizedString("Лучшие треки", comment: ""), attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}
