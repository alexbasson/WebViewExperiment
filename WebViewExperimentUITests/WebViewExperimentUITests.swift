//
//  WebViewExperimentUITests.swift
//  WebViewExperimentUITests
//
//  Created by Alex on 2/6/20.
//  Copyright © 2020 Conditionally Convergent. All rights reserved.
//

import XCTest

class WebViewExperimentUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        

//        XCTAssert(app.staticTexts["Just Launched"].exists)
//
//        app.staticTexts["Just Launched"].tap()


        let justLaunched = app.links["DETAILS"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: justLaunched, handler: nil)

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(justLaunched.exists)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
