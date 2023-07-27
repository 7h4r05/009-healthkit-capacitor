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
    
    @objc
    func observeHR(_ call: CAPPluginCall) {
        call.keepAlive = true
        NotificationCenter.default.addObserver(forName: .onHeartRateValueUpdated, object: nil, queue: .main) {  notification in
            print(notification.object)
            call.resolve(["heartRate": notification.object ])
        }
     }
}
