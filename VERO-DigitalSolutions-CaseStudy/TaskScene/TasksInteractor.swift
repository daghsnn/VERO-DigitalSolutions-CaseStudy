//
//  TasksInteractor.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol TasksBusinessLogic: AnyObject {
    func viewDidLoad() async
}

protocol TasksDataStore {
    //var name: String { get set }
}

final class TasksInteractor: TasksBusinessLogic, TasksDataStore {
    var presenter: TasksPresentationLogic?
    var worker: TasksWorker = TasksWorker()
    //var name: String = ""
    
    // MARK: Do something
    
    func viewDidLoad() async {
        worker.getUserTasks()
        let response = Tasks.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
