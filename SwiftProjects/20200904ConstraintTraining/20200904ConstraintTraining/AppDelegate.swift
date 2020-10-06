//
//  AppDelegate.swift
//  20200904ConstraintTraining
//
//  Created by 박영호 on 2020/09/04.
//  Copyright © 2020 Park young ho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appCoordinator = AppCoordinator.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let window = self.window else { return false }
        
        appCoordinator.start(inWindow: window)

//        PHRepository.requestPhotoAuth {
//
//        }
        
        DeviceOrientationHelper.shared.startDeviceOrientationNotifier()
        
        return true
    }
    
    
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
}

