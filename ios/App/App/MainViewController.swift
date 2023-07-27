//
//  MainViewController.swift
//  App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//

import Foundation
import Capacitor
import WatchConnectivity

class MainViewController: CAPBridgeViewController, WCSessionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let value = message["heartRate"] as? Int
        
        NotificationCenter.default.post(name: .onHeartRateValueUpdated, object: value)
    }
    
    func session(_ session: WCSession, didReceiveUserInfo message: [String: Any]) {
        let value = message["heartRate"] as? Int
        
        NotificationCenter.default.post(name: .onHeartRateValueUpdated, object: value)
    }
}
