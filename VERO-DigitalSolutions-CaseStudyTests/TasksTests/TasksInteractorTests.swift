//
//  TasksInteractorTests.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 22.02.2023.
//

import XCTest
@testable import VERO_DigitalSolutions_CaseStudy

final class TasksInteractorTests: XCTestCase {
    var sut : TasksInteractor!
    var presenter : SpyTasksPresenter!

    override func setUpWithError() throws {
        sut = TasksInteractor()
        presenter = SpyTasksPresenter()
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
    

    func test_businessLogic_invokeViewWillAppear() throws {
        XCTAssertFalse(presenter.invokedViewWillAppear)
        sut.viewWillAppear()
        XCTAssertTrue(presenter.invokedViewWillAppear)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
