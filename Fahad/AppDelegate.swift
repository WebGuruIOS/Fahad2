//
//  AppDelegate.swift
//  Fahad
//
//  Created by Kondalu on 13/08/21.

import UIKit
import CoreData
import IQKeyboardManagerSwift
import LanguageManager_iOS
import Stripe
import Firebase
import Messages

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        FirebaseApp.configure()
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
//  let tabBarController  = storyboard.instantiateViewController(withIdentifier: "menuBar") as! menuBar
//                window?.rootViewController = tabBarController
//                window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        LanguageManager.shared.defaultLanguage = .deviceLanguage
       
        // Override point for customization after application launch.
        //"sk_test_51IJfoeH1N76XU1NeCm6AaLEWNv8tu7N4krXwUbp43BQx8WSk1DPo2WKx2OjN9sPD1aatJw640rUa4Yp0qtTz7rwv00CCzJN2Tz"
        
        STPAPIClient.shared.publishableKey =
        "pk_live_51IF2yVJKWWQQ3ypr0tDsx4ULLo1Q9iYLvzRgOzerZWk8Rmbbjkm8ULCsqH3zNpIv2AbnOnwIUmKDZmTKtAIuvGLJ00DLD2Vtdh"
        
//        STPAPIClient.shared.publishableKey = "pk_test_51IJfoeH1N76XU1NeoWOCqZKbYSdSNUaarlUs4FiPPkKFVArXiRevCDMTkciJyXCEB4KuUtZTOLivLYbBQ9RjYMc600xtmvqW2g"
//        "sk_test_51KYoz8SEMglFDS7pHHuBBAiUS4uKf2hTKweqQ79O7mtSN4lq28vyeL68HibDtuSO3DT9yGBXMjjUhkWNtGsjs8AB00GQMatp2B"
        
        
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
       // FirebaseApp.configure()
        return true
    }
    
    func check(){
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
                let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homePage = mainStoryboard.instantiateViewController(withIdentifier: "menuBar") as! menuBar
                self.window?.rootViewController = homePage
           
        }else{

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigationController.viewControllers = [rootViewController]
                self.window?.rootViewController = navigationController
               
        }
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                       -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
    }

    // MARK: UISceneSession Lifecycle
   

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Fahad")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

  //CHANGE code
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate{
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo
    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound, .badge]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print full message.
    print(userInfo)

    completionHandler()
  }
}

extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
      /*
         Firebase registration token: Optional("eYnzmbWlgkZMu7L54TxxtI:APA91bFZtUAVwNWNniQBz-AnsqSapcYOHHs-QXbljvKoA2iv5BvBtcPnhh1v6laRP-aKvjyf4RrkOTNZdkvaZ-bEdjHR_EeTGtLKT35PN1d8siJmrtVaXJF0HEexiC4ELjFkSdZfj-wp")
         */
        
      let dataDict: [String: String] = ["token": fcmToken ?? ""]
        print(dataDict["token"]!)
        UserDefaults.standard.set(dataDict["token"]!, forKey: "fcmToken")
       /*
         1 element
          ▿ 0 : 2 elements
            - key : "token"
            - value : "eYnzmbWlgkZMu7L54TxxtI:APA91bFZtUAVwNWNniQBz-AnsqSapcYOHHs-QXbljvKoA2iv5BvBtcPnhh1v6laRP-aKvjyf4RrkOTNZdkvaZ-bEdjHR_EeTGtLKT35PN1d8siJmrtVaXJF0HEexiC4ELjFkSdZfj-wp"
         */
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    
//    Messaging.messaging().token { token, error in
//      if let error = error {
//        print("Error fetching FCM registration token: \(error)")
//      } else if let token = token {
//        print("FCM registration token: \(token)")
//        self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//      }
//    }

}
