//
//  profilemodel.swift
//  Fitness
//
//  Created by Namrata Akash on 31/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import Foundation
class profilemodel
{
    var profile_id:Int?
    var name:String?
    var display_name:String?
    var gender:String?
    var dob:String?
    var mail:String?
    var mobile_no:String?
    var area:String?
    var city:String?
    var country:String?
    var about_us:String?
    var batch_detail:String?
    var user_profile_img:String?
    var user_cover_img:String?
    
    
    
    init(profile_id:Int,name:String,mail:String) {
        self.profile_id = profile_id
        self.name = name
        self.mail = mail
    }
    init(profile_id:Int,name:String,display_name:String,gender:String,dob:String,mail:String,mobile_no:String,area:String,city:String,country:String,about_us:String,batch_detail:String,user_profile_img:String,user_cover_img:String) {
        self.profile_id = profile_id
        self.name = name
        self.display_name = display_name
        self.gender = gender
        self.dob = dob
        self.mail = mail
        self.mobile_no = mobile_no
        self.area = area
        self.city = city
        self.country = country
        self.about_us = about_us
        self.batch_detail = batch_detail
        self.user_cover_img = user_cover_img
        self.user_profile_img = user_profile_img
    }
    init(profile_id:Int) {
        self.profile_id = profile_id
    }
}
