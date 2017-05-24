//
//  AppValues .swift
//  FireBaseRemote
//
//  Created by Siwaporn Dee on 5/19/2560 BE.
//  Copyright © 2560 Siwaporn Dee. All rights reserved.
//

import Foundation
import Firebase

class AppValues {
    
    static let sharedInstance = AppValues()
    
    private init() {
        loadDefaultValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: NSObject] = [
            "appPrimaryColor" : "#FBB03B" as NSObject        ]
        FIRRemoteConfig.remoteConfig().setDefaults(appDefaults)
    }
}
