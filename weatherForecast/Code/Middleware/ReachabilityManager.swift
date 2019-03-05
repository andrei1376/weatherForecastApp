//
//  ReachabilityManager.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 05/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation
import Reachability

public protocol NetworkStatusListener: class {
    func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager: NSObject {
    static let shared = ReachabilityManager()  // 2. Shared instance

    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }

    var reachabilityStatus: Reachability.Connection = .none

    let reachability = Reachability()!

    var listeners = [NetworkStatusListener]()


    @objc func reachabilityChanged(notification: Notification) {

        let reachability = notification.object as! Reachability

        switch reachability.connection {
        case .none:
            debugPrint("Network became unreachable")
        default:
            debugPrint("Network reachable")
        }

        // Sending message to each of the delegates
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.connection)
        }
    }

    func startMonitoring() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }

    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }

    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }

    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
