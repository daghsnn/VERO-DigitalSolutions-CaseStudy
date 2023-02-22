//
//  LoginSpy.swift
//  VERO-DigitalSolutions-CaseStudyTests
//
//  Created by Hasan Dag on 21.02.2023.
//

import Foundation

@testable import VERO_DigitalSolutions_CaseStudy

final class SpyLoginInteractor : LoginBusinessLogic {

    var invokedViewDidLoad = false

    func viewDidLoad() {
        invokedViewDidLoad = true
    }

    var invokedHandleLogin = false
    var invokedHandleLoginParameters: (requestModel: LoginRequestModel, Void)?

    func handleLogin(_ requestModel:LoginRequestModel) {
        invokedHandleLogin = true
        invokedHandleLoginParameters = (requestModel, ())
    }
}

final class SpyLoginPresenter : LoginPresentationLogic {

    var invokedViewDidLoad = false

    func viewDidLoad() {
        invokedViewDidLoad = true
    }

    var invokedPresentViewModel = false
    var invokedPresentViewModelParameters: (response: LoginResponseModel?, Void)?

    func presentViewModel(response: LoginResponseModel?) {
        invokedPresentViewModel = true
        invokedPresentViewModelParameters = (response, ())
    }

    var invokedPresentError = false
    var invokedPresentErrorParameters: (errorMessage: String?, Void)?

    func presentError(errorMessage: String?) {
        invokedPresentError = true
        invokedPresentErrorParameters = (errorMessage, ())
    }
}

final class SpyLoginViewController : LoginDisplayLogic, LoginViewInterfaceable {

    var invokedInteractorGetter = false
    var invokedInteractorGetterCount = 0
    var stubbedInteractor: LoginBusinessLogic!

    var interactor: LoginBusinessLogic? {
        invokedInteractorGetter = true
        invokedInteractorGetterCount += 1
        return stubbedInteractor
    }

    var invokedRouterGetter = false
    var invokedRouterGetterCount = 0
    var stubbedRouter: (LoginRoutingLogic & LoginDataPassing)!

    var router: (LoginRoutingLogic & LoginDataPassing)? {
        invokedRouterGetter = true
        invokedRouterGetterCount += 1
        return stubbedRouter
    }

    var invokedWhenViewDidLoad = false

    func whenViewDidLoad() {
        invokedWhenViewDidLoad = true
    }

    var invokedDisplayLogic = false
    var invokedDisplayLogicParameters: (viewModel: LoginViewModel, Void)?
    var invokedDisplayLogicParametersList = [(viewModel: LoginViewModel, Void)]()

    func displayLogic(viewModel: LoginViewModel) {
        invokedDisplayLogic = true
        invokedDisplayLogicParameters = (viewModel, ())
        invokedDisplayLogicParametersList.append((viewModel, ()))
    }

    var invokedDisplayError = false
    var invokedDisplayErrorParameters: (message: String, Void)?
    var invokedDisplayErrorParametersList = [(message: String, Void)]()

    func displayError(_ message:String) {
        invokedDisplayError = true
        invokedDisplayErrorParameters = (message, ())
        invokedDisplayErrorParametersList.append((message, ()))
    }
}

final class SpyLoginRouter : LoginRoutingLogic, LoginDataPassing {

    var invokedDataStoreGetter = false
    var stubbedDataStore: LoginDataStore!

    var dataStore: LoginDataStore? {
        invokedDataStoreGetter = true
        return stubbedDataStore
    }

    var invokedRouteToTasks = false

    func routeToTasks() {
        invokedRouteToTasks = true
    }
}
