//
//  TaskSpy.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 22.02.2023.
//

import Foundation
@testable import VERO_DigitalSolutions_CaseStudy

final class SpyTasksViewController : TasksDisplayLogic, TaskViewInterfaceable, CameraHandleDelegate {

    var invokedInteractorGetter = false
    var stubbedInteractor: TasksBusinessLogic!

    var interactor: TasksBusinessLogic? {
        invokedInteractorGetter = true
        return stubbedInteractor
    }

    var invokedRouterGetter = false
    var stubbedRouter: (TasksRoutingLogic &  TasksDataPassing)!

    var router: (TasksRoutingLogic &  TasksDataPassing)? {
        invokedRouterGetter = true
        return stubbedRouter
    }

    var invokedWhenViewDidLoad = false

    func whenViewDidLoad() {
        invokedWhenViewDidLoad = true
    }

    var invokedWhenViewWillAppear = false

    func whenViewWillAppear() {
        invokedWhenViewWillAppear = true
    }

    var invokedDisplayLogic = false
    var invokedDisplayLogicParameters: (viewModel: TasksViewModel, isEditing: Bool)?
    var invokedDisplayLogicParametersList = [(viewModel: TasksViewModel, isEditing: Bool)]()

    func displayLogic(viewModel: TasksViewModel, isEditing: Bool) {
        invokedDisplayLogic = true
        invokedDisplayLogicParameters = (viewModel, isEditing)
        invokedDisplayLogicParametersList.append((viewModel, isEditing))
    }

    var invokedDisplayError = false
    var invokedDisplayErrorCount = 0
    var invokedDisplayErrorParameters: (message: String, Void)?
    var invokedDisplayErrorParametersList = [(message: String, Void)]()

    func displayError(_ message: String) {
        invokedDisplayError = true
        invokedDisplayErrorCount += 1
        invokedDisplayErrorParameters = (message, ())
        invokedDisplayErrorParametersList.append((message, ()))
    }

    var invokedPrepareQRScanningResult = false
    var invokedPrepareQRScanningResultParameters: (text: String, Void)?
    var invokedPrepareQRScanningResultParametersList = [(text: String, Void)]()

    func prepareQRScanningResult(_ text:String) {
        invokedPrepareQRScanningResult = true
        invokedPrepareQRScanningResultParameters = (text, ())
        invokedPrepareQRScanningResultParametersList.append((text, ()))
    }
}

final class SpyTasksInteractor : TasksBusinessLogic {

    var invokedViewDidLoad = false

    func viewDidLoad() {
        invokedViewDidLoad = true
    }

    var invokedViewWillAppear = false

    func viewWillAppear() {
        invokedViewWillAppear = true
    }

    var invokedGetModels = false

    func getModels() {
        invokedGetModels = true
    }

    var invokedConfigureCancelSearch = false
    var invokedConfigureCancelSearchParameters: (isEditing: Bool, Void)?
    var invokedConfigureCancelSearchParametersList = [(isEditing: Bool, Void)]()

    func configureCancelSearch(_ isEditing:Bool) {
        invokedConfigureCancelSearch = true
        invokedConfigureCancelSearchParameters = (isEditing, ())
        invokedConfigureCancelSearchParametersList.append((isEditing, ()))
    }

    var invokedConfigureSearching = false
    var invokedConfigureSearchingParameters: (searchText: String, isPressBackSpace: Bool)?
    var invokedConfigureSearchingParametersList = [(searchText: String, isPressBackSpace: Bool)]()

    func configureSearching(_ searchText: String, _ isPressBackSpace:Bool) {
        invokedConfigureSearching = true
        invokedConfigureSearchingParameters = (searchText, isPressBackSpace)
        invokedConfigureSearchingParametersList.append((searchText, isPressBackSpace))
    }
}

final class SpyTasksRouter : TasksRoutingLogic, TasksDataPassing {

    var invokedDataStoreGetter = false
    var stubbedDataStore: TasksDataStore!

    var dataStore: TasksDataStore? {
        invokedDataStoreGetter = true
        return stubbedDataStore
    }

    var invokedRouteToCameraVC = false

    func routeToCameraVC() {
        invokedRouteToCameraVC = true
    }
}

final class SpyTasksPresenter : TasksPresentationLogic {

    var invokedViewDidLoad = false

    func viewDidLoad() {
        invokedViewDidLoad = true
    }

    var invokedViewWillAppear = false

    func viewWillAppear() {
        invokedViewWillAppear = true
    }

    var invokedPresentViewModel = false
    var invokedPresentViewModelParameters: (response: [TasksResponseModel]?, isSearching: Bool)?
    var invokedPresentViewModelParametersList = [(response: [TasksResponseModel]?, isSearching: Bool)]()

    func presentViewModel(response: [TasksResponseModel]?, isSearching:Bool) {
        invokedPresentViewModel = true
        invokedPresentViewModelParameters = (response, isSearching)
        invokedPresentViewModelParametersList.append((response, isSearching))
    }

    var invokedPresentError = false
    var invokedPresentErrorParameters: (errorMessage: String?, Void)?
    var invokedPresentErrorParametersList = [(errorMessage: String?, Void)]()

    func presentError(errorMessage: String?) {
        invokedPresentError = true
        invokedPresentErrorParameters = (errorMessage, ())
        invokedPresentErrorParametersList.append((errorMessage, ()))
    }
}
