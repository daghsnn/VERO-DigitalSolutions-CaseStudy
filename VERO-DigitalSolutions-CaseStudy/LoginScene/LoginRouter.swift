//
//  LoginRouter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {
    func routeToTasks()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToTasks(){
        let destination = TasksViewController()
        viewController?.navigationController?.modalTransitionStyle = .crossDissolve
        viewController?.navigationController?.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
