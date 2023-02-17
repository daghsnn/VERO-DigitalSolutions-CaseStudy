//
//  LoginRouter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {
    //func routeToSomewhere()
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    
    // MARK: Navigation
    
    //func routeToSomewhere() {

    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: LoginDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
