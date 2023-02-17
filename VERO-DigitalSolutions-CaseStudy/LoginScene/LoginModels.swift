//
//  LoginModels.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation
    
struct LoginRequestModel : Codable {
    let username, password : String?
}
struct LoginResponseModel : Codable {
    let oauth: Oauth?
    let userInfo: UserInfo?
    let permissions: [String]?
    let apiVersion: String?
    let showPasswordPrompt: Bool?
}

struct Oauth: Codable {
    let accessToken: String?
    let expiresIn: Int?
    let tokenType: String?
    let scope: String?
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
        case refreshToken = "refresh_token"
    }
}

struct UserInfo: Codable {
    let personalNo: Int?
    let firstName, lastName, displayName: String?
    let active: Bool?
    let businessUnit: String?
}

struct LoginViewModel {
    
}


// TODO: Bu model ayarlanabilir

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

