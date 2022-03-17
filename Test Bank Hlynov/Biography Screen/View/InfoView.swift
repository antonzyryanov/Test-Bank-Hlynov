import UIKit

final class InfoView: ResponseView {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var infoTextView: UITextView = {
        var infoTextView = UITextView()
        infoTextView.isScrollEnabled = true
        infoTextView.isEditable = false
        infoTextView.isUserInteractionEnabled = true
        return infoTextView
    }()

    func updateArtistInfo(name: String, biography: String) {
        self.titleLabel.text = name
        self.infoTextView.text = biography
    }

    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView()
        self.setupCustomFonts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let containerView = UIView()
        addSubview(containerView)
        containerView.addSubview(self.imageView)
        containerView.addSubview(self.titleLabel)
        containerView.addSubview(self.infoTextView)

        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        self.imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(185)
        }

        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottomMargin).inset(-25)
            make.height.equalTo(30)
        }

        self.infoTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottomMargin).inset(-25)
            make.bottom.equalToSuperview()
        }
    }

    private func setupCustomFonts() {
        self.infoTextView.font = UIFont(name: "Roboto-Regular", size: 16)
        self.titleLabel.font = UIFont(name: "Roboto-Bold", size: 26)
    }
}
