//
//  TasksSceneTest.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 22.02.2023.
//

import XCTest
@testable import VERO_DigitalSolutions_CaseStudy

final class TasksSceneTest: XCTestCase {
    var sut : TasksViewController!
    var interactor : SpyTasksInteractor!
    var router : SpyTasksRouter!

    override func setUpWithError() throws {
        sut = TasksViewController()
        interactor = SpyTasksInteractor()
        router = SpyTasksRouter()
        sut.router = router
        sut.interactor = interactor
    }

    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        router = nil
    }

    func test_displayLogic_invokeViewDidLoad() throws {
        XCTAssertFalse(interactor.invokedViewDidLoad)
        sut.viewDidLoad()
        XCTAssertTrue(interactor.invokedViewDidLoad)
    }

    func test_displayLogic_invokeViewWillAppear() throws {
        XCTAssertFalse(interactor.invokedViewWillAppear)
        sut.viewWillAppear(true)
        XCTAssertTrue(interactor.invokedViewWillAppear)
    }
    
    func test_invokedRouter() throws {
        XCTAssertFalse(router.invokedRouteToCameraVC)
        sut.qrButtonTapped()
        XCTAssertTrue(router.invokedRouteToCameraVC)
    }

    func test_displayLogic_invokeConfigureCancelSearch() throws {
        XCTAssertFalse(interactor.invokedConfigureCancelSearch)
        sut.searchBar(UISearchBar(), textDidChange: "")
        XCTAssertTrue(interactor.invokedConfigureCancelSearch)
    }
    
    func test_displayLogic_invokeSearch() throws {
        XCTAssertFalse(interactor.invokedConfigureSearching)
        sut.searchBar(UISearchBar(), textDidChange: "1321")
        XCTAssertTrue(interactor.invokedConfigureSearching)
    }
    
    func test_collectionView_numberOfItems() throws {
        XCTAssertEqual(sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()), numberOfItemsInSection: 0), 0)
        sut.displayLogic(viewModel: TasksViewModel.init(responseModel: mockModel))
        XCTAssertEqual(sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()), numberOfItemsInSection: 0), 2)
    }
    
    
}

var mockModel : [TasksResponseModel] = [TasksResponseModel(task: "test", title: "test", description: nil, sort: nil, wageType: nil, businessUnitKey: nil, businessUnit: nil, parentTaskID: nil, preplanningBoardQuickSelect: nil, colorCode: nil, workingTime: nil, isAvailableInTimeTrackingKioskMode: nil),
    TasksResponseModel(task: "test", title: "test",description: nil, sort: nil, wageType: nil,businessUnitKey: nil, businessUnit: nil,parentTaskID: nil,preplanningBoardQuickSelect: nil, colorCode:nil, workingTime: nil,isAvailableInTimeTrackingKioskMode: nil)]
