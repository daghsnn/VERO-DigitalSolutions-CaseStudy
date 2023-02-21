//
//  TasksRouter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol TasksRoutingLogic {
    func routeToCameraVC()
}

protocol TasksDataPassing {
    var dataStore: TasksDataStore? { get }
}

final class TasksRouter: NSObject, TasksRoutingLogic, TasksDataPassing {
    weak var viewController: TasksViewController?
    var dataStore: TasksDataStore?
    
    func routeToCameraVC() {
        let destination = CameraViewController()
        destination.delegate = viewController
        viewController?.modalTransitionStyle = .crossDissolve
        viewController?.modalPresentationStyle = .overFullScreen
        viewController?.present(destination, animated: true)
    }
}
