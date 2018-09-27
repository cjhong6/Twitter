//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Chengjiu Hong on 9/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User{
    var name: String
    var screenName: String
    var id: Int64
    
    init(dictionary: [String: Any]) {
        name = (dictionary["name"] as? String)!
        screenName = (dictionary["screen_name"] as? String)!
        id = dictionary["id"] as! Int64
        // Initialize any other properties
    }
    
    static var current: User?{
        get{
            return nil
        }
        set(user){

        }
    }
}
