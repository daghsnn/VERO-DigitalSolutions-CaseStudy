//
//  ReachabilityManager.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//

import Alamofire

final class ReachabilityManager  {
    
    static let shared : ReachabilityManager = ReachabilityManager()
    private let reachabilityManager: NetworkReachabilityManager = NetworkReachabilityManager(host: "www.google.com")!
    private(set) var isOnline = false
    
    private init() {
        isOnline = self.configureReachability()
    }
    
    private func configureReachability() -> Bool {
        return reachabilityManager.isReachable
    }
}
