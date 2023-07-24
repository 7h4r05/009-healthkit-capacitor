//
//  MainView.swift
//  WatchApp Watch App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//

import SwiftUI
import Combine
import WatchConnectivity


struct ContentView: View {
    @State private var value = "0"

    var body: some View {
        VStack {
            TextField("Input", text: $value)
                        .padding()
            
            Button("Send value to phone") {
                WCSession.default.sendMessage(["value": self.value], replyHandler: nil)
            }
            .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: .onCapValueUpdated), perform: { val in
            self.value = String(describing: val.object!)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
