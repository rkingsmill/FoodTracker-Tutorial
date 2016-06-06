//
//  User.swift
//  FoodTracker
//
//  Created by Rosalyn Kingsmill on 2016-06-06.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class User: NSObject {
    
        var password: String
        var username: String
        var token: String?
        //var token: String
        
        init(username: String, password: String) {
            // Initialize stored properties.
            self.username = username
            self.password = password
            //self.token = (username+password).sha256String
        }
}
