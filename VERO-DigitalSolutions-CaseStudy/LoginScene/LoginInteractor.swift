//
//  LoginInteractor.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic : AnyObject {
    func viewDidLoad()
    func handleLogin(_ requestModel:LoginRequestModel)
}

protocol LoginDataStore {
    var accessToken: String? { get set }
    var tokenType: String? { get set }
    var expiresIn: Int? { get set }
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker = LoginWorker()
    
    var accessToken: String?
    var tokenType: String?
    var expiresIn: Int?
    
    func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    func handleLogin(_ requestModel:LoginRequestModel) {
        worker.getUserLogin(model: requestModel) { [weak self] loginModel, error in
            if let error = error {
                self?.presenter?.presentError(errorMessage: error.message)
            } else {
                self?.accessToken = loginModel?.oauth?.accessToken
                self?.tokenType = loginModel?.oauth?.tokenType
                self?.expiresIn = loginModel?.oauth?.expiresIn
                self?.presenter?.presentViewModel(response: loginModel)
            }
        }
    }
}
