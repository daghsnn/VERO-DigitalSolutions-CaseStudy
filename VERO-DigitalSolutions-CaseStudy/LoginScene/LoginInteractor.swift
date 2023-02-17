//
//  LoginInteractor.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic {
    func doSomething(request: LoginRequestModel)
}

protocol LoginDataStore {
    //var name: String { get set }
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: LoginRequestModel) {
        worker = LoginWorker()
        worker?.doSomeWork()
//        presenter?.presentSomething(response: response)
    }
}
