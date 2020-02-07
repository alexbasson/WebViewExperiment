import XCTest
import WebKit

@testable import WebViewExperiment

class ViewControllerTests: XCTestCase {

    var viewController: ViewController!
    var navController: UINavigationController!
    let baseURL = URL(string: "https://www.dickssportinggoods.com/")!

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "ViewController")
        navController = UINavigationController.init(rootViewController: viewController)

        XCTAssertNotNil(navController.view)
        XCTAssertNotNil(viewController.view)
    }

    func testItLoadsTheDSGWebsite() {
        XCTAssertEqual(viewController.webView.url!, baseURL)
    }

    func testWhenANavigationActionOccurs_IfTheActionIsNotLinkActivated_ItDoesNotNavigateToAnotherViewController() {
        let navDelegate = viewController.webView.navigationDelegate!

        let request = buildRequest(withMainDocumentURL: baseURL)
        let navigationAction = StubNavigationAction(navigationType: .other, request: request)

        navDelegate.webView!(viewController.webView, decidePolicyFor: navigationAction, decisionHandler: {(_) in })

        waitForAnimations()

        XCTAssertEqual(navController.topViewController, viewController)
    }

    func testWhenANavigationActionOccurs_IfTheActionIsLinkActivated_AndThePathIsNotToTheCart_ItNavigatesToAnotherViewController() {
        let navDelegate = viewController.webView.navigationDelegate!

        let request = buildRequest(withMainDocumentURL: baseURL.appendingPathComponent("some non-cart route"))
        let navigationAction = StubNavigationAction(navigationType: .linkActivated, request: request)

        navDelegate.webView!(viewController.webView, decidePolicyFor: navigationAction, decisionHandler: {(_) in })

        waitForAnimations()

        XCTAssertEqual(navController.topViewController, viewController)
    }

    func testWhenANavigationActionOccurs_IfTheActionIsLinkActivated_AndThePathIsToTheCart_ItNavigatesToAnotherViewController() {
        let navDelegate = viewController.webView.navigationDelegate!

        let request = buildRequest(withMainDocumentURL: baseURL.appendingPathComponent("OrderItemDisplay"))
        let navigationAction = StubNavigationAction(navigationType: .linkActivated, request: request)

        navDelegate.webView!(viewController.webView, decidePolicyFor: navigationAction, decisionHandler: {(_) in })

        waitForAnimations()

        XCTAssertNotEqual(navController.topViewController, viewController)
    }

    private func waitForAnimations() {
        let animations = expectation(description: "animations")
        let _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (Timer) in
            animations.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}

class StubNavigationAction: WKNavigationAction {
    let testRequest: URLRequest
    let testNavigationType: WKNavigationType

    override var navigationType: WKNavigationType {
        return testNavigationType
    }

    override var request: URLRequest {
        return testRequest
    }

    init(navigationType: WKNavigationType, request: URLRequest) {
        testNavigationType = navigationType
        testRequest = request
        super.init()
    }
}

func buildRequest(withMainDocumentURL mainDocumentURL: URL) -> URLRequest {
    var request = URLRequest(url: mainDocumentURL)
    request.mainDocumentURL = mainDocumentURL
    return request
}

