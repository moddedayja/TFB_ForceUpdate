

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        let _ = RCValues.sharedInstance
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //RCValues.sharedInstance.fetchCloudValues()
        print ("current\(self.version())")
        print ("forceUpdateVersion\(RCValues.sharedInstance.forceUpdateVersion())")

        let currentVersion:String = self.version()
        let forceUpdateVersion:String = RCValues.sharedInstance.forceUpdateVersion()
        let forceUpdateUrl:String = RCValues.sharedInstance.forceUpdateUrl()
        let url = Foundation.URL(string: forceUpdateUrl)
        
        if(currentVersion.versionToInt().lexicographicallyPrecedes(forceUpdateVersion.versionToInt())){
            
            let alert = UIAlertController(title: "New Version",
                                          message: "Please ,update application to new version.",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let updateAction = UIAlertAction(title: "Update",
                                             style: .cancel, handler: { (UIAlertAction) in
                                                if #available(iOS 10.0, *) {
                                                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                                                } else {
                                                    UIApplication.shared.openURL(url!)
                                                }
            })
            
            alert.addAction(updateAction)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            


        }

    }
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        //let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return build
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}


extension String {
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int.init($0) ?? 0 }
    }
}
//true

