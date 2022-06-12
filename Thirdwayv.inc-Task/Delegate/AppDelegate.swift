//
//  AppDelegate.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           do {
               try Network.reachability = Reachability(hostname: "www.google.com")
           }
           catch {
               switch error as? Network.Error {
               case let .failedToCreateWith(hostname)?:
                   print("Network error:\nFailed to create reachability object With host named:", hostname)
               case let .failedToInitializeWith(address)?:
                   print("Network error:\nFailed to initialize reachability object With address:", address)
               case .failedToSetCallout?:
                   print("Network error:\nFailed to set callout")
               case .failedToSetDispatchQueue?:
                   print("Network error:\nFailed to set DispatchQueue")
               case .none:
                   print(error)
               }
           }
           return true
       }
 
   }
