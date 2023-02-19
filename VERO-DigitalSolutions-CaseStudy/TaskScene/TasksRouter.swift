//
//  TasksRouter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol TasksRoutingLogic {
    //func routeToSomewhere()
}

protocol TasksDataPassing {
    var dataStore: TasksDataStore? { get }
}

final class TasksRouter: NSObject, TasksRoutingLogic, TasksDataPassing {
    weak var viewController: TasksViewController?
    var dataStore: TasksDataStore?
    
    
    // MARK: Navigation
    
    //func routeToSomewhere() {

    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: TasksDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
