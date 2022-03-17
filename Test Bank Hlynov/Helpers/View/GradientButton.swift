import UIKit

class GradientButton: UIButton {
    private var firstColor: CGColor = UIColor.white.cgColor
    private var secondColor: CGColor = UIColor.white.cgColor

    init(firstColor: CGColor, secondColor: CGColor) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.firstColor, self.secondColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
}
