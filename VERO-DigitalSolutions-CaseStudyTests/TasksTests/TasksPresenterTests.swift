//
//  TasksPresenterTests.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 22.02.2023.
//

import XCTest
@testable import VERO_DigitalSolutions_CaseStudy

final class TasksPresenterTests: XCTestCase {
    var sut : TasksPresenter!
    var controller : SpyTasksViewController!

    override func setUpWithError() throws {
        sut = TasksPresenter()
        controller = SpyTasksViewController()
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

    func test_PresentLogic_invokeviewWillAppear() throws {
        XCTAssertFalse(controller.invokedWhenViewWillAppear)
        sut.viewWillAppear()
        XCTAssertTrue(controller.invokedWhenViewWillAppear)
    }
    
    func test_PresentLogic_invokeDisplayError() throws {
        XCTAssertFalse(controller.invokedDisplayError)
        sut.presentError(errorMessage: "Test Error")
        XCTAssertEqual(controller.invokedDisplayErrorParameters?.message, "Test Error")
    }
    
    func test_PresentLogic_invokepresentViewModel_Nil() throws {
        XCTAssertFalse(controller.invokedDisplayLogic)
        sut.presentViewModel(response: nil)
        XCTAssertNil(controller.invokedDisplayLogicParameters?.viewModel)
    }
    
    func test_PresentLogic_invokepresentViewModel() throws {
        XCTAssertFalse(controller.invokedDisplayLogic)
        sut.presentViewModel(response: mockModel)
        XCTAssertEqual(controller.invokedDisplayLogicParameters?.viewModel.responseModel.count,2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
