//
//  ExtensionDelegate.swift
//  WatchApp Watch App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//


import WatchKit
import WatchConnectivity
import CoreData


class ExtensionDelegate: NSObject, WKApplicationDelegate, WCSessionDelegate {
    override init() {
        super.init()
        assert(WCSession.isSupported(), "WatchConnectivity is required!")
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let value = message["value"] as? String
        
        NotificationCenter.default.post(name: .onCapValueUpdated, object: value)
    }
}
