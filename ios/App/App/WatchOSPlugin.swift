//
//  WatchOSPlugin.swift
//  App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//

import Foundation
import WatchConnectivity
import Capacitor
import Combine

class ResponseStatus {
    let NotSupported = 1
    let NotReachable = 2
    let NotPaired = 3
    let CommunicationProblem = 4
    let ActivationFailure = 5
    let WatchAppNotInstalled = 6
    let OK = 0
}

@objc(WatchOSPlugin)
class WatchOSPlugin : CAPPlugin {
    
    @objc(getState:)
    func getState(_ call: CAPPluginCall) {
        var result = ResponseStatus().CommunicationProblem
        if (WCSession.isSupported()){
            let state = WCSession.default.activationState
            if state == WCSessionActivationState.activated {
                WCSession.default.activate()
                if (WCSession.default.isPaired)
                {
                    if (WCSession.default.isWatchAppInstalled) {
                        if (!WCSession.default.isReachable) {
                            result = ResponseStatus().NotReachable
                        } else {
                            result = ResponseStatus().OK
                        }
                    } else {
                        result = ResponseStatus().WatchAppNotInstalled
                    }
                } else {
                    result = ResponseStatus().NotPaired
                }
            } else {
                result = ResponseStatus().ActivationFailure
            }
        } else {
            result = ResponseStatus().NotSupported
        }
        call.resolve(["status": result])
    }
    
    @objc(setValue:)
    func setValue(_ call: CAPPluginCall){
        let value = call.getString("value")
        WCSession.default.sendMessage(["value": value], replyHandler: nil)
    }
    
    @objc
    func subscribe(_ call: CAPPluginCall) {
         call.keepAlive = true
        NotificationCenter.default.addObserver(forName: .onWatchValueUpdated, object: nil, queue: .main) {  notification in
            call.resolve(["value": notification.object ])
        }
        
     }
}
