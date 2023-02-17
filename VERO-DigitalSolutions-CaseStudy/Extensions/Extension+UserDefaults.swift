//
//  Extension+UserDefaults.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultKeys: String , CaseIterable {
        case mainModel
    }
    
    func getCacheModels() -> [LoginResponseModel]? {
        if let data = data(forKey: UserDefaultKeys.mainModel.rawValue) {
            do {
                let cachedModel = try JSONDecoder().decode([LoginResponseModel].self, from: data)
                return cachedModel
            } catch {
                
            }
        }
        
        return nil
    }
    
    func saveModeltoCache(_ cacheModel: [LoginResponseModel]) {
        do {
            let data = try JSONEncoder().encode(cacheModel)
            set(data, forKey: UserDefaultKeys.mainModel.rawValue)
            synchronize()
        } catch let encodeError {
            print("Failed to encode countModel ",encodeError)
        }
    }
}
