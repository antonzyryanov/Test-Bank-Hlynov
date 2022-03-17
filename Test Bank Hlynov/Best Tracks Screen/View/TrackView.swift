import UIKit

final class TrackView: UIView {
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage()
        imageView.backgroundColor = .gray
        return imageView
    }()

    var titleTextView: UITextView = {
        var textView = UITextView()
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        return textView
    }()

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateView(track: Track) {
        self.titleTextView.text = track.name
    }

    private func setupView() {
        addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        addSubview(self.titleTextView)
        self.titleTextView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).inset(-24)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
