//
//  AppValues .swift
//  FireBaseRemote
//
//  Created by Siwaporn Dee on 5/19/2560 BE.
//  Copyright © 2560 Siwaporn Dee. All rights reserved.
//

import Foundation
import Firebase
enum ValueKey: String {
    case appPrimaryColor
}
class RCValues  {
    
    static let sharedInstance = RCValues()
    
    private init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    func loadDefaultValues() {

        FIRRemoteConfig.remoteConfig().setDefaultsFromPlistFileName("RemoteConfigDefaults")

    }
    
    func fetchCloudValues() {
        // 1
        // WARNING: Don't actually do this in production!
        let fetchDuration: TimeInterval = 0
        // If your app is using developer mode, expirationDuration is set to 0, so each fetch will
        // retrieve values from the Remote Config service.
        
        activateDebugMode()
        FIRRemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) {
            [weak self] (status, error) in
            
            guard error == nil else {
                print ("Uh-oh. Got an error fetching remote values \(String(describing: error))")
                return
            }
            
            // 2
            FIRRemoteConfig.remoteConfig().activateFetched()
            print ("Retrieved values from the cloud!")
            print ("Our app's primary color is \(String(describing: FIRRemoteConfig.remoteConfig().configValue(forKey: "appPrimaryColor").stringValue))")
            
//            // ADD THESE TWO LINES HERE!
        }
    }
    
    func forceUpdateVersion() -> String {
        let force_update_version = FIRRemoteConfig.remoteConfig().configValue(forKey: "force_update_version").stringValue
        return force_update_version!
    }
    func activateDebugMode() {
        let debugSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        FIRRemoteConfig.remoteConfig().configSettings = debugSettings!
    }
    
    func color(forKey key: ValueKey) -> UIColor {
        let colorAsHexString = FIRRemoteConfig.remoteConfig()[key.rawValue].stringValue ?? "#FFFFFFFF"
        let convertedColor = UIColor(cgColor: colorAsHexString as! CGColor)
        return convertedColor
    }
}
