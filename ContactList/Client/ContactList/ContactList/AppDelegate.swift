//
//  AppDelegate.swift
//  ContactList
//
//  Created by Andrea Prearo on 7/9/19.
//  Copyright © 2019 Andrea Prearo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var  coreDataStack = CoreDataStack(modelName: "ContactList")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return instantiateContactsViewController()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
}

extension AppDelegate {
    func instantiateContactsViewController() -> Bool {
        let storyboard = UIStoryboard(name: StoryboardIdentifiers.main.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllersIdentifiers.contacts.rawValue) as? ContactsViewController else {
            return false
        }
        
        viewController.coreDataStack = coreDataStack
        let navController = UINavigationController(rootViewController: viewController)
        viewController.title = "Contacts"
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
