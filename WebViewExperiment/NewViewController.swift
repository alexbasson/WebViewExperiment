import UIKit

class NewViewController: UIViewController {

    var request: URLRequest?
    var cookies: [HTTPCookie]?

    @IBOutlet var routeLabel: UILabel!
    @IBOutlet var paramsLabel: UILabel!
    @IBOutlet var headersLabel: UILabel!
    @IBOutlet var cookiesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let request = request, let url = request.url {
            routeLabel.text = url.path

            if let query = url.query {
                let params = query.split(separator: "&")
                paramsLabel.numberOfLines = params.count
                paramsLabel.text = params.joined(separator: "\n")
            }

            if let headers = request.allHTTPHeaderFields {
                headersLabel.numberOfLines = headers.count
                headersLabel.text = headers
                    .map { header in return "\(header.key): \(header.value)" }
                    .joined(separator: "\n")
            }

            if let cookies = cookies {
                cookiesLabel.numberOfLines = cookies.count
                cookiesLabel.text = cookies
                    .map { cookie in return "\(cookie)" }
                    .joined(separator: "\n")
            } else {
                cookiesLabel.text = "No cookies found"
            }
        }
    }
}
