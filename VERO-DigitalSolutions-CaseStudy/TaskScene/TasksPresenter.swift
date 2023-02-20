//
//  TasksPresenter.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

protocol TasksPresentationLogic : AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func presentViewModel(response: [TasksResponseModel]?)
    func presentError(errorMessage: String?)

}

final class TasksPresenter: TasksPresentationLogic {
    weak var viewController: TasksDisplayLogic?
    
    func viewDidLoad() {
        viewController?.whenViewDidLoad()
    }
    
    func viewWillAppear() {
        viewController?.whenViewWillAppear()
    }

    func presentViewModel(response: [TasksResponseModel]?){
        if let response {
            self.viewController?.displayLogic(viewModel: TasksViewModel(responseModel: response))
        }
    }
    
    func presentError(errorMessage: String?){
        if let errorMessage {
            viewController?.displayError(errorMessage)
        }
    }
}
