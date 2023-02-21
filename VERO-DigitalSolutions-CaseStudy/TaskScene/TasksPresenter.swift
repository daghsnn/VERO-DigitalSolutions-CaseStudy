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
    func presentViewModel(response: [TasksResponseModel]?, isSearching:Bool)
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

    func presentViewModel(response: [TasksResponseModel]?, isSearching:Bool = false){
        if let response = response, response.count > 0 {
            self.viewController?.displayLogic(viewModel: TasksViewModel(responseModel: response), isEditing: isSearching)
        } else {
            presentError(errorMessage: "Tasks not found")
        }
    }
    
    func presentError(errorMessage: String?){
        if let errorMessage {
            viewController?.displayError(errorMessage)
        }
    }
}
