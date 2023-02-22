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
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker = LoginWorker()
    
    var accessToken: String?{
        didSet{
            if let token = accessToken {
                UserDefaults.standard.token = token
            }
        }
    }
    
    var tokenType: String?{
        didSet{
            if let type = tokenType {
                UserDefaults.standard.tokenType = type
            }
        }
    }
    
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
                self?.presenter?.presentViewModel(response: loginModel)
            }
        }
    }
}
