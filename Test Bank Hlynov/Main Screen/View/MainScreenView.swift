import SnapKit
import UIKit

final class MainScreenView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Поиск музыкальных исполнителей", comment: "")
        return label
    }()

    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .purple
        return divider
    }()

    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = NSLocalizedString("Сервис позволяет найти лучшие треки исполнителей и показывает биографию", comment: "")
        return subtitleLabel
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "picture")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    public let firstOptionButton: UIButton = {
        let firstColor = UIColor(red: 251 / 255, green: 194 / 255, blue: 235 / 255, alpha: 1.0)
        let secondColor = UIColor(red: 166 / 255, green: 193 / 255, blue: 238 / 255, alpha: 1.0)
        let button = GradientButton(firstColor: firstColor.cgColor, secondColor: secondColor.cgColor)
        button.setTitle(NSLocalizedString("Биография артиста", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemPink
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    private let secondOptionButton: UIButton = {
        let firstColor = UIColor(red: 240 / 255, green: 147 / 255, blue: 251 / 255, alpha: 1.0)
        let secondColor = UIColor(red: 245 / 255, green: 87 / 255, blue: 108 / 255, alpha: 1.0)
        let button = GradientButton(firstColor: firstColor.cgColor, secondColor: secondColor.cgColor)
        button.setTitle(NSLocalizedString("Лучшие треки", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemPink
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    init(
        firstOptionButtonAction: @escaping () -> Void,
        secondOptionButtonAction: @escaping () -> Void
    ) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView(firstOptionButtonAction: firstOptionButtonAction, secondOptionButtonAction: secondOptionButtonAction)
        self.setupCustomFonts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(
        firstOptionButtonAction: @escaping () -> Void,
        secondOptionButtonAction: @escaping () -> Void
    ) {
        backgroundColor = .white

        addSubview(self.imageView)

        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(68)
        }

        addSubview(self.divider)
        self.divider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottomMargin).inset(-21)
            make.height.equalTo(1)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
        }

        addSubview(self.subtitleLabel)
        self.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(divider).inset(21)
            make.leading.equalToSuperview().inset(37)
            make.trailing.equalToSuperview().inset(37)
            make.height.equalTo(57)
        }

        addSubview(self.secondOptionButton)
        self.secondOptionButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.bottom.equalToSuperview().inset(21)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
        }
        self.secondOptionButton.addAction(secondOptionButtonAction)

        addSubview(self.firstOptionButton)
        self.firstOptionButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.bottom.equalTo(secondOptionButton.snp.topMargin).inset(-21)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
        }
        self.firstOptionButton.addAction(firstOptionButtonAction)

        self.imageView.snp.makeConstraints { make in
            make.bottom.equalTo(firstOptionButton.snp.topMargin).inset(-10)
            make.top.equalTo(subtitleLabel.snp.bottomMargin).inset(-10)
            make.centerX.equalToSuperview()
        }
    }

    private func setupCustomFonts() {
        self.titleLabel.font = UIFont(name: "Roboto-Bold", size: 29)
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0

        self.subtitleLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        self.subtitleLabel.lineBreakMode = .byWordWrapping
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.textColor = UIColor(red: 123 / 255, green: 123 / 255, blue: 123 / 255, alpha: 1)

        self.firstOptionButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        self.secondOptionButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
    }
}
