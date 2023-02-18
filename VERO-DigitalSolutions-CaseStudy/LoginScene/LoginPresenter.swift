//
//  LoginPresenter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol LoginPresentationLogic : AnyObject {
    func viewDidLoad()
    func presentViewModel(response: LoginResponseModel?)
    func presentError(errorMessage: String?)
}

final class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    func viewDidLoad() {
        viewController?.whenViewDidLoad()
    }

    func presentViewModel(response: LoginResponseModel?){
        viewController?.displayLogic(viewModel: LoginViewModel(success: true))
    }
    
    func presentError(errorMessage: String?){
        if let message = errorMessage {
            viewController?.displayError(message)
        }
    }
}
