//
//  MainView.swift
//  WatchApp Watch App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//

import SwiftUI
import Combine
import WatchConnectivity
import HealthKit


struct ContentView: View {
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    @State private var value = 0
    
    var body: some View {
        VStack{
            Text("❤️ \(value)")
                .font(.system(size: 50))
            
            
        }
        .padding()
        .onAppear(perform: watchHeartRate)
    }
    
    
    private func watchHeartRate() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        // enable background delivery
        healthStore.enableBackgroundDelivery(for: heartRateType, frequency: .immediate, withCompletion: { isCompleted,error in
            
        } )
        
        
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: .heartRate)
            
        }
        
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: .heartRate)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        if !samples.isEmpty {
            let sample = samples.last!
            if type == .heartRate {
                self.value = Int(sample.quantity.doubleValue(for: heartRateQuantity))
                
                if !WCSession.default.isReachable {
                    WCSession.default.sendMessage(["heartRate": self.value], replyHandler: nil)
                } else {
                    WCSession.default.transferUserInfo(["heartRate": self.value])
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
