//
//  LoginPresenterTests.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 22.02.2023.
//

import XCTest
@testable import VERO_DigitalSolutions_CaseStudy

final class LoginPresenterTests: XCTestCase {
    var sut : LoginPresenter!
    var controller : (SpyLoginViewController & LoginViewInterfaceable)!

    override func setUpWithError() throws {
        sut = LoginPresenter()
        controller = SpyLoginViewController()
        sut.viewController = controller
    }

    override func tearDownWithError() throws {
        sut = nil
        controller = nil
    }

    func test_PresentLogic_invokeViewDidLoad() throws {
        XCTAssertFalse(controller.invokedWhenViewDidLoad)
        sut.viewDidLoad()
        XCTAssertTrue(controller.invokedWhenViewDidLoad)
    }

    func test_PresentLogic_invokedisplayLogic() throws {
        XCTAssertFalse(controller.invokedDisplayLogic)
        sut.presentViewModel(response: nil)
        XCTAssertTrue(controller.invokedDisplayLogic)
    }

    func test_PresentLogic_invokeErrorMessage() throws {
        XCTAssertFalse(controller.invokedDisplayError)
        sut.presentError(errorMessage: "Test message")
        XCTAssertEqual(controller.invokedDisplayErrorParameters?.message, "Test message")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
