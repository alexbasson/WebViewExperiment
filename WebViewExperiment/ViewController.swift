import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var destinationRequest: URLRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self

        let url = URL(string: "https://www.dickssportinggoods.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNewViewController" {
            if let request = destinationRequest {
                if let newViewController = segue.destination as? NewViewController {
                    newViewController.request = request
                    let dataStore = WKWebsiteDataStore.default()
                    dataStore.httpCookieStore.getAllCookies({ (cookies) in newViewController.cookies = cookies })
                }
            }
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("=============================> Navigation type: \(navigationAction.navigationType.toString())")

        if let url = navigationAction.request.mainDocumentURL {
            print("=============================> Request: \(url)")
            print("=============================> Route: \(url.path)")

            if navigationAction.navigationType == .linkActivated && url.path == "/OrderItemDisplay" {
                decisionHandler(.cancel)
                destinationRequest = navigationAction.request
                self.performSegue(withIdentifier: "ShowNewViewController", sender: self)
                return
            }
        }
        decisionHandler(.allow)
    }
}

extension WKNavigationType {
    func toString() -> String {
        switch self {
        case .linkActivated:
            return "link activated"
        case .formSubmitted:
            return "form submitted"
        case .backForward:
            return "back forward"
        case .reload:
            return "reload"
        case .formResubmitted:
            return "form resubmitted"
        default:
            return "other"
        }
    }
}
