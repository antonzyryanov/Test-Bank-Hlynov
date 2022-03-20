import UIKit

class SearchView: UIView {
    
    let scrollView = UIScrollView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    var searchBarView: SearchBarView = {
        let searchView = SearchBarView()
        return searchView
    }()

    let searchButton: UIButton = {
        let firstColor = UIColor(red: 251 / 255, green: 194 / 255, blue: 235 / 255, alpha: 1.0)
        let secondColor = UIColor(red: 166 / 255, green: 193 / 255, blue: 238 / 255, alpha: 1.0)
        let button = GradientButton(firstColor: firstColor.cgColor, secondColor: secondColor.cgColor)
        button.setTitle(NSLocalizedString("Искать", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemPink
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    private let goBackButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Вернуться назад", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let responseView: ResponseView

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor(red: 245 / 255, green: 87 / 255, blue: 108 / 255, alpha: 1.0)
        return activityIndicator
    }()

    let splashView: UIView = {
        let splashView = UIView()
        splashView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.6)
        return splashView
    }()

    required init(goBackButtonAction: @escaping () -> Void, responseView: ResponseView) {
        self.responseView = responseView
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView(goBackButtonAction: goBackButtonAction)
        self.setupCustomFonts()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(goBackButtonAction: @escaping () -> Void) {
        backgroundColor = .white
        
        addSubview(self.scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        scrollView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(71)
            make.leading.equalToSuperview().inset(36)
            make.trailing.equalToSuperview().inset(36)
            make.height.equalTo(29)
        }

        scrollView.addSubview(self.searchButton)
        self.searchButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(209)
            make.leading.equalTo(self).inset(102)
            make.trailing.equalTo(self).inset(102)
            make.height.equalTo(55)
        }

        scrollView.addSubview(self.searchBarView)
        self.searchBarView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottomMargin).inset(-57)
            make.leading.equalTo(self).inset(36)
            make.trailing.equalTo(self).inset(36)
            make.height.equalTo(28)
        }

        scrollView.addSubview(self.responseView)
        self.responseView.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottomMargin).inset(-32)
            make.height.equalTo(415)
            make.leading.equalTo(self).inset(36)
            make.trailing.equalTo(self).inset(36.0)
        }
        
        scrollView.addSubview(self.goBackButton)
        self.goBackButton.snp.makeConstraints { make in
            make.top.equalTo(self.responseView.snp.bottom).inset(-60)
            make.bottom.equalToSuperview().inset(29)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        self.goBackButton.addAction(goBackButtonAction)

        addSubview(self.splashView)
        self.splashView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        self.splashView.isHidden = true

        addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        self.activityIndicator.isHidden = true
    }

    private func setupCustomFonts() {
        self.titleLabel.font = UIFont(name: "Roboto-Bold", size: 29)
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0

        self.searchButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)

        self.goBackButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        self.goBackButton.underline()
        
    }
    
}
