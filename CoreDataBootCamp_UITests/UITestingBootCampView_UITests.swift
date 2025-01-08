//
//  UITestingBootCampView_UITests.swift
//  CoreDataBootCamp_UITests
//
//  Created by Vincent Joy on 08/01/25.
//

import XCTest

// Naming structure :- test_UnitOfWork_StateUnderTest_ExpectedBehaviour = test_[class]_[ui component]_[expected result]
// Testing structure :- Given, When, Then

final class UITestingBootCampView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testUITestingBootCampView_signupButton_shouldNotSignIn() {
        app.textFields["SignupTextField"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["SignupButton"].tap()
        
        let navigationBar = app.navigationBars["Welcome"]
        
        XCTAssertFalse(navigationBar.exists)
    }
    
    func testUITestingBootCampView_signupButton_shouldSignIn() {
        
        app.textFields["SignupTextField"].tap()
        
        let AKey = app.keys["A"]
        AKey.tap()
        let aKey = app.keys["a"]
        aKey.tap()
        aKey.tap()
        aKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["SignupButton"].tap()
        
        let navigationBar = app.navigationBars["Welcome"]
        
        XCTAssertTrue(navigationBar.exists)
    }
}
