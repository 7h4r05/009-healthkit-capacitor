//
//  WatchOSPlugin.m
//  App
//
//  Created by Dariusz Zabrzeński on 01/07/2023.
//

#import <Capacitor/Capacitor.h>

CAP_PLUGIN(WatchOSPlugin, "WatchOSPlugin",
           CAP_PLUGIN_METHOD(getState, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(observeHR, CAPPluginReturnCallback);
           
)
