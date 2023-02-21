//
//  LoginWorker.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class LoginWorker {
    
    func getUserLogin(model:LoginRequestModel, completion: @escaping (LoginResponseModel?, Error?) ->()) {
        let mirror = Mirror(reflecting: model)
        var params = [String: Any]()
        
        for case let (label?, value) in mirror.children {
            params[label] = value
        }
        
        let service = NetworkService.shared
        service.methods = .post
        service.headers = ["Authorization": Constants.BASIC_TOKEN.rawValue,
                           "Content-Type": "application/json"]
        service.sendRequest(path: .login, params: params) {[weak self] data, error in
            if let error = error{
                completion(nil,error)
            } else if let data = data {
                if let loginModel = try? JSONDecoder().decode(LoginResponseModel.self, from: data) {
                    completion(loginModel,nil)
                }
            }
        }
    }
}

