import UIKit

class SearchViewController<T: SearchView, S: ResponseView>: UIViewController, UITextFieldDelegate {
    var networkManager: NetworkManager?

    var artistName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private func setupUI() {
        self.view = T(goBackButtonAction: {
            self.dismiss(animated: true, completion: nil)
        }, responseView: S())

        guard let searchView = self.view as? T else { return }
        guard let responseView = searchView.responseView as? S else { return }

        responseView.isHidden = true

        searchView.searchButton.addTarget(self, action: #selector(self.searchButtonPressed), for: .touchUpInside)
        searchView.searchBarView.searchTextField.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func searchButtonPressed() {
        self.dismissKeyboard()
        guard let searchView = self.view as? T else { return }
        searchView.splashView.isHidden = false
        searchView.activityIndicator.isHidden = false
        searchView.activityIndicator.startAnimating()
        self.performRequest {
            searchView.activityIndicator.stopAnimating()
            searchView.activityIndicator.isHidden = true
            searchView.splashView.isHidden = true
        }
    }

    func performRequest(onCompletion: @escaping () -> Void) {}

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.artistName = text
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        self.artistName = text
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
