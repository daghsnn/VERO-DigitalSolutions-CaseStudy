//
//  TasksModels.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

enum Tasks {
    
    enum Something {
        struct Request {
            
        }
        struct Response {
            
        }
        
    }
}

struct TasksViewModel {
    let responseModel : [TasksResponseModel]
}

struct TasksResponseModel: Codable {
    let task, title, description, sort: String?
    let wageType: String?
    let businessUnitKey: String?
    let businessUnit: String?
    let parentTaskID: String?
    let preplanningBoardQuickSelect: String?
    let colorCode: String?
    let workingTime: String?
    let isAvailableInTimeTrackingKioskMode: Bool?

    enum CodingKeys: String, CodingKey {
        case task, title, description, sort, wageType
        case businessUnitKey = "BusinessUnitKey"
        case businessUnit, parentTaskID, preplanningBoardQuickSelect, colorCode, workingTime, isAvailableInTimeTrackingKioskMode
    }
}
