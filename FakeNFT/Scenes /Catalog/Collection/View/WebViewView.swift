import UIKit
import WebKit

final class WebViewView: UIViewController {

    var url: URL?

    private lazy var webView: WKWebView = {
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .textPrimary
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        addSubviews()
        setupLayout()
        makeNavBar()
        loadWebView()

    }

    private func loadWebView() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    private func addSubviews() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func makeNavBar() {
        if let navBar = navigationController?.navigationBar {
            let leftButton = UIBarButtonItem(
                image: UIImage(named: "chevronBackward"),
                style: .plain,
                target: self,
                action: #selector(self.didTapBackButton)
            )
            navigationItem.leftBarButtonItem = leftButton
            navBar.tintColor = .textPrimary
        }
    }

    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
