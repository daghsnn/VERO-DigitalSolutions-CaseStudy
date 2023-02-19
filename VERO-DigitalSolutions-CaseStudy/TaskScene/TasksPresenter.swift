//
//  TasksPresenter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol TasksPresentationLogic : AnyObject {
    func presentSomething(response: Tasks.Something.Response)
}

final class TasksPresenter: TasksPresentationLogic {
    weak var viewController: TasksDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Tasks.Something.Response) {
        let viewModel = Tasks.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
