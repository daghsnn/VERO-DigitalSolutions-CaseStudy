//
//  TasksInteractor.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol TasksBusinessLogic: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func getModels() async
}

protocol TasksDataStore {
    //var name: String { get set }
}

final class TasksInteractor: TasksBusinessLogic, TasksDataStore {

    var presenter: TasksPresentationLogic?
    var worker: TasksWorker = TasksWorker()
    //var name: String = ""
    
    // MARK: Do something
    
    fileprivate func saveCacheModel(_ model:[TasksResponseModel]?) {
        if let model {
            UserDefaults.standard.saveModeltoCache(model)
        }
    }
    
    func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    func viewWillAppear() {
        presenter?.viewWillAppear()
    }
    func getModels() async {
        worker.getUserTasks { [weak self] model, error in
            if let error {
                self?.presenter?.presentError(errorMessage: error.message)
            } else {
                self?.saveCacheModel(model)
                self?.presenter?.presentViewModel(response: model)
            }
        }
    }
}
