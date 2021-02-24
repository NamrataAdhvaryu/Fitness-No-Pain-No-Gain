//
//  Loginmodel.swift
//  Fitness
//
//  Created by Namrata Akash on 15/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import Foundation
class userloginModel
{
    var user_password:String?
    var user_email:String?
    var name:String?
  
    
    
    init(user_email:String,user_password:String) {
      
        self.user_email = user_email
        self.user_password = user_password
        
        
    }
    //to get user id
    init(name:String,user_email:String?) {
        self.name = name
        self.user_email = user_email
    }
}
