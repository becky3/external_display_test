import UIKit
import WebKit

class ViewController: UIViewController {

    private let webView = WKWebView()
    private var externalWindow : UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
    }

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(addExternalDisplay(notification:)),
            name: UIScreen.didConnectNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(removeExternalDisplay(notification:)),
            name: UIScreen.didDisconnectNotification,
            object: nil
        )
    }
    
    @objc func addExternalDisplay(notification : Notification) {

        guard let newScreen = notification.object as? UIScreen else {
            return
        }

        let screenDimensions = newScreen.bounds
        let newWindow = UIWindow(frame: screenDimensions)

        newWindow.screen = newScreen
        webView.frame = newWindow.frame
        newWindow.addSubview(webView)
        newWindow.isHidden = false
        
        // window を破棄させないため プロパティに保持
        externalWindow = newWindow
    }

    @objc func removeExternalDisplay(notification : Notification) {
        externalWindow = nil
    }
    
    
    @IBAction func didTapButton0(_ sender: Any) {
        load(urlString: "https://www.google.com")
    }
    @IBAction func didTapButton1(_ sender: Any) {
        load(urlString: "https://www.yahoo.co.jp")
    }
    @IBAction func didTapButton2(_ sender: Any) {
        load(urlString: "https://www.apple.com/jp")
    }
    
    private func load(urlString : String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

}

