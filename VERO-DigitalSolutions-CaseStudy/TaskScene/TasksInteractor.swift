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
    func configureCancelSearch(_ isEditing:Bool)
    func configureSearching(_ searchText: String, _ isPressBackSpace:Bool)
}

protocol TasksDataStore {
    var responseModel : [TasksResponseModel]? {get set}
}

final class TasksInteractor: TasksBusinessLogic, TasksDataStore {

    var presenter: TasksPresentationLogic?
    var worker: TasksWorker = TasksWorker()
    
    var responseModel : [TasksResponseModel]?
    
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
                self?.responseModel = model
                self?.saveCacheModel(model)
                self?.presenter?.presentViewModel(response: model, isSearching: false)
            }
        }
    }
    
    func configureCancelSearch(_ isEditing:Bool) {
        presenter?.presentViewModel(response: self.responseModel, isSearching: isEditing)
    }
    
    func configureSearching(_ searchText: String, _ isPressBackSpace: Bool) {
        if isPressBackSpace {
            self.configureCancelSearch(true)
        }
        presenter?.presentViewModel(response: getSearchResults(searchText), isSearching: false)
    }
    
    private func getSearchResults(_ keyword : String) -> [TasksResponseModel]? {
        let searchResults = responseModel?.filter{$0.task?.contains(keyword) ?? false ||
                                                $0.title?.contains(keyword) ?? false ||
                                                $0.description?.contains(keyword) ?? false ||
                                                $0.wageType?.contains(keyword) ?? false ||
                                                $0.parentTaskID?.contains(keyword) ?? false ||
                                                $0.businessUnit?.contains(keyword) ?? false
        }
        return searchResults
    }
}
