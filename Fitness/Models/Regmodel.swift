//
//  Regmodel.swift
//  Fitness
//
//  Created by Namrata Akash on 18/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import Foundation
class userRegistrationModel
{   var id:Int?
    var user_name:String?
    var user_password:String?
    var user_email:String?
    var user_mobilenumber:String?
    
    
    init(user_name:String,user_email:String,user_password:String,user_mobilenumber:String) {
        self.user_name = user_name
        self.user_email = user_email
        self.user_password = user_password
        self.user_mobilenumber = user_mobilenumber
        
    }
    init(user_id:Int,user_password:String)
    {
        self.id = user_id
        self.user_password = user_password
    }
}
