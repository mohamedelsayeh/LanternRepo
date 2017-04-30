//
//  NetworkManager.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 4/17/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import Alamofire

final class NetworkManager: NSObject {
    
    private var networkStatus : NetworkStatus = .unknown;
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

    private override init() {
        super.init()
    }
    static let sharedManager = NetworkManager()

    func reachabilityStatus(statusCompletion: ((NetworkStatus) -> Void)!) {
        listenForReachability(completion: statusCompletion);
    }
    
    func listenForReachability(completion: ((NetworkStatus) -> Void)!) {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                self.networkStatus = .notConnected
                print("The network is not reachable")
            case .unknown :
                self.networkStatus = .unknown
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                self.networkStatus = .connectedViaWifi
                print("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                self.networkStatus = .connectedVia3G
                print("The network is reachable over the WWAN connection")
            }
            completion(self.networkStatus)
        }
        reachabilityManager?.startListening()
    }
    
    public enum NetworkStatus {
        case unknown
        case notConnected
        case connectedViaWifi
        case connectedVia3G
    }
}
