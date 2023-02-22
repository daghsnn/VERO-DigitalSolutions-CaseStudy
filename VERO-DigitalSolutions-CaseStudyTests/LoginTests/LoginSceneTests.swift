//
//  LoginSceneTests.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 21.02.2023.
//

import XCTest

@testable import VERO_DigitalSolutions_CaseStudy

final class LoginSceneTests: XCTestCase {
    var sut : LoginViewController!
    var interactor : SpyLoginInteractor!
    var router : SpyLoginRouter!
    override func setUpWithError() throws {
        sut = LoginViewController()
        interactor = SpyLoginInteractor()
        router = SpyLoginRouter()
        sut.interactor = interactor
        sut.router = router
    }

    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
    }

    func test_displayLogic_invokeViewDidLoad() throws {
        // Given
        XCTAssertFalse(interactor.invokedViewDidLoad)
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(interactor.invokedViewDidLoad)
        
    }
    
    func test_displayLogic_invokeLogin() throws {
        XCTAssertFalse(interactor.invokedHandleLogin)
        sut.displayLogic(viewModel: LoginViewModel(success: true))
        sut.loginClicked()
        XCTAssertTrue(interactor.invokedHandleLogin)
    }
    
    func test_displayLogic_isRequestModelValid() throws {
        // Given
        XCTAssertNil(interactor.invokedHandleLoginParameters)
        sut.interactor = interactor
        // When
        sut.interactor?.handleLogin(LoginRequestModel(username: "123", password: "1"))
        // Then
        XCTAssertTrue(interactor.invokedHandleLogin)
        XCTAssertEqual(interactor.invokedHandleLoginParameters?.requestModel.username, "123")
        XCTAssertEqual(interactor.invokedHandleLoginParameters?.requestModel.password, "1")
    }
    
    func test_displayLogic_invokedRouter() throws {
        XCTAssertFalse(router.invokedRouteToTasks)
        router.routeToTasks()
        XCTAssertTrue(router.invokedRouteToTasks)
    }

}
