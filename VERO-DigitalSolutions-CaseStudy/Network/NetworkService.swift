//
//  NetworkService.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//

import Alamofire
import Foundation

enum EndPoints : String {
    case tasks = "/dev/index.php/v1/tasks/select"
    case login = "/index.php/login"
}

protocol BaseServiceProtocol:AnyObject {
    func sendRequest(path: EndPoints, params:[String:Any]?,_ completion: @escaping(Data?, Error?) -> Void)
    var baseUrl: String {get set}
    var methods : HTTPMethod? {get set}
    var headers : HTTPHeaders? {get set}
}

final class NetworkService : BaseServiceProtocol {

    var baseUrl: String = Constants.BASE_URL.rawValue
    var methods: Alamofire.HTTPMethod?
    var headers: Alamofire.HTTPHeaders?
    static let shared : NetworkService = NetworkService()
    private init() {}
    
    func sendRequest(path: EndPoints, params:[String:Any]? = nil,_ completion: @escaping(Data?, Error?) -> ()) {
        
        if ReachabilityManager.shared.isOnline {
            AF.request(self.baseUrl + path.rawValue, method:self.methods ?? .get, parameters:params, encoding:JSONEncoding.default, headers:self.headers).responseData { response in
                do {
                    if response.response?.statusCode == 200 {
                        // MARK: Caching with FileManager

//                        if path == .tasks {
//                            let key = "cacheKey"
//                            let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
//                            let fileUrl = cachesDirectory.appendingPathComponent(key)
//                            do {
//                                let encodedData = try JSONEncoder().encode(response.data)
//                                try encodedData.write(to: fileUrl)
//                            } catch {
//                                print("Error caching data: \(error.localizedDescription)")
//                            }
//                        }
                        

                        completion(response.data, nil)
                    } else {
                        let errorModel = try JSONDecoder().decode(LoginErrorModel.self, from: response.data ?? Data())
                        completion(nil,Error(code: errorModel.error?.code, message: errorModel.error?.message))
                    }
                } catch {
                    completion(nil,Error(code: nil, message: error.localizedDescription))
                }
            }
        } else {
            if path == .tasks {
                // MARK: Caching with UserDefaults
                let model = UserDefaults.standard.getCacheModels()
                do {
                    let data = try JSONEncoder().encode(model)
                    completion(data,nil)
                } catch {
                    completion(nil,Error(code: nil, message: error.localizedDescription))
                }
                // MARK: Get Cached data with FileManager
//                let key = "cacheKey"
//                let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
//                let fileUrl = cachesDirectory.appendingPathComponent(key)
//                if let data = try? Data(contentsOf: fileUrl) {
//                    completion(data,nil)
//                }
            }
        }
        
    }
}
