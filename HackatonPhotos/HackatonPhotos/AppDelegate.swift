//
//  AppDelegate.swift
//  HackatonPhotos
//
//  Created by Denis Loctier on 11/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        // Apply a red background.
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = .systemBackground
        
        // Apply white colored normal and large titles.
//        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

//        // Apply white color to all the nav bar buttons.
//        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
//        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
//        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
//        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
//        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
//        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
//        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        return customNavBarAppearance
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let newNavBarAppearance = customNavBarAppearance()
               
           let appearance = UINavigationBar.appearance()
           appearance.scrollEdgeAppearance = newNavBarAppearance
           appearance.compactAppearance = newNavBarAppearance
           appearance.standardAppearance = newNavBarAppearance
           if #available(iOS 15.0, *) {
               appearance.compactScrollEdgeAppearance = newNavBarAppearance
           }

           return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

