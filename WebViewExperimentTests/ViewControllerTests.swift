import XCTest

@testable import WebViewExperiment

class ViewControllerTests: XCTestCase {

    var viewController: ViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "ViewController")

        let _ = viewController.view
    }

    func testItLoadsTheDSGWebsite() {
        XCTAssertEqual(viewController.webView.url!.absoluteString, "https://www.dickssportinggoods.com/")
    }

}
