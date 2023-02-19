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
                        completion(response.data, nil)
                    } else {
                        let errorModel = try JSONDecoder().decode(LoginErrorModel.self, from: response.data ?? Data())
                        completion(nil,Error(code: errorModel.error?.code, message: errorModel.error?.message))
                    }
                } catch {
                    completion(nil,Error(code: nil, message: "A problem happened"))
                }
            }
        } else {
            // cache
        }
        
    }
}
