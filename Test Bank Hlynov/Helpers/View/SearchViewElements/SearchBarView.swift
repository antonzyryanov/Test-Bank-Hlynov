import SnapKit
import UIKit

class SearchBarView: UIView {
    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search-interface-symbol")
        return imageView
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()

    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Кого ищем?"
        return textField
    }()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView()
        self.setupCustomFonts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(self.searchIconImageView)
        self.searchIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().inset(4)
            make.height.equalTo(11)
            make.width.equalTo(11)
        }

        addSubview(self.searchTextField)
        self.searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchIconImageView.snp.trailingMargin).inset(-18)
            make.top.equalToSuperview().inset(2)
            make.trailing.equalToSuperview()
        }

        addSubview(self.divider)
        self.divider.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    private func setupCustomFonts() {
        self.searchTextField.font = UIFont(name: "Roboto-Light", size: 12)
    }
}
