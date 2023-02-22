//
//  LoginInteractorTests.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 22.02.2023.
//

import XCTest
@testable import VERO_DigitalSolutions_CaseStudy

final class LoginInteractorTests: XCTestCase {
    var sut : LoginInteractor!
    var presenter : SpyLoginPresenter!
    override func setUpWithError() throws {
        sut = LoginInteractor()
        presenter = SpyLoginPresenter()
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
    }

    func test_businessLogic_invokeViewDidLoad() throws {
        XCTAssertFalse(presenter.invokedViewDidLoad)
        sut.viewDidLoad()
        XCTAssertTrue(presenter.invokedViewDidLoad)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
