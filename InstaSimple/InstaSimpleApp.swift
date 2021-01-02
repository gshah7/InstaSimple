//
//  InstaSimpleApp.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import SwiftUI
import Firebase

@main
struct InstaSimpleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SessionStore())
        }
    }
}
