//
//  ios_webviewApp.swift
//  ios-webview
//
//  Created by TAK IN OH on 2022/08/11.
//

import SwiftUI

@main
struct WebviewApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        #if DEBUG
        print("schema DEBUG")
        #else
        print("schema RELEASE")
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
