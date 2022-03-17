import UIKit

final class ArtistTracksView: ResponseView {
    private var containerView: UIView = {
        return UIView()
    }()

    var firstTrack: TrackView = {
        return TrackView()
    }()

    var secondTrack: TrackView = {
        return TrackView()
    }()

    var thirdTrack: TrackView = {
        return TrackView()
    }()

    required init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
        self.setupCustomFonts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(self.containerView)
        self.containerView.addSubview(self.firstTrack)
        self.containerView.addSubview(self.secondTrack)
        self.containerView.addSubview(self.thirdTrack)

        self.containerView.snp.makeConstraints { make in
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
            make.centerY.equalToSuperview()
        }

        self.firstTrack.snp.makeConstraints { make in
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
            make.top.equalToSuperview()
            make.height.equalTo(80)
        }

        self.secondTrack.snp.makeConstraints { make in
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
            make.top.equalTo(firstTrack.snp.bottomMargin).inset(-32)
            make.height.equalTo(80)
        }

        self.thirdTrack.snp.makeConstraints { make in
            make.leading.equalTo(0.0)
            make.trailing.equalTo(0.0)
            make.top.equalTo(secondTrack.snp.bottomMargin).inset(-32)
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
    }

    func updateView(firstTrack: Track, secondTrack: Track, thirdTrack: Track) {
        self.firstTrack.updateView(track: firstTrack)
        self.secondTrack.updateView(track: secondTrack)
        self.thirdTrack.updateView(track: thirdTrack)
    }

    private func setupCustomFonts() {
        self.firstTrack.titleTextView.font = UIFont(name: "Roboto-Bold", size: 19)
        self.secondTrack.titleTextView.font = UIFont(name: "Roboto-Bold", size: 19)
        self.thirdTrack.titleTextView.font = UIFont(name: "Roboto-Bold", size: 19)
        self.firstTrack.titleTextView.textColor = UIColor(red: 109 / 255, green: 109 / 255, blue: 109 / 255, alpha: 1)
        self.secondTrack.titleTextView.textColor = UIColor(red: 109 / 255, green: 109 / 255, blue: 109 / 255, alpha: 1)
        self.thirdTrack.titleTextView.textColor = UIColor(red: 109 / 255, green: 109 / 255, blue: 109 / 255, alpha: 1)
    }
}
