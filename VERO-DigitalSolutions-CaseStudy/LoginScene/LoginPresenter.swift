//
//  LoginPresenter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol LoginPresentationLogic : AnyObject {
    func presentSomething(response: LoginResponseModel)
}

final class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: LoginResponseModel) {
//        let viewModel = Login.Something.ViewModel()
//        viewController?.displaySomething(viewModel: viewModel)
    }
}
