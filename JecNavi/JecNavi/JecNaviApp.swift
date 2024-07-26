//
//  JecNaviApp.swift
//  JecNavi
//
//  Created by yuki on 2024/06/11.
//

import SwiftUI
import FirebaseCore
import FirebaseAuthUI
import FirebaseGoogleAuthUI

@main
struct JecNaviApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
        SplashScreenView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: options[.sourceApplication] as? String) ?? false
    }
}



