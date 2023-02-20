//
//  TasksWorker.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class TasksWorker {
    func getUserTasks(completion: @escaping ([TasksResponseModel]?, Error?) ->()) {
        let service = NetworkService.shared
        service.methods = .get
        service.headers = ["Authorization": String(format: Constants.BEARER.rawValue, UserDefaults.standard.tokenType,UserDefaults.standard.token),
                           "Content-Type": "application/json"]
        service.sendRequest(path: .tasks) {[weak self] data, error in
            if let error = error{
                completion(nil,error)
            } else if let data = data {
                if let responseModel = try? JSONDecoder().decode([TasksResponseModel].self, from: data) {
                    completion(responseModel,nil)
                }
            }
        }
    }
}
