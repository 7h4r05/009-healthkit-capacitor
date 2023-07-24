//
//  WatchAppApp.swift
//  WatchApp Watch App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//

import SwiftUI

@main
struct WatchApp_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor(ExtensionDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
