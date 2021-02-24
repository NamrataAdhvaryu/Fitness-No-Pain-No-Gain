//
//  Bookingmodel.swift
//  Fitness
//
//  Created by Namrata Akash on 20/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import Foundation
class bookingmodel
{
    var user_id:Int?
    var booking_date:String?
    var booking_time:String?
    var booking_cat:String?
    var booking_area:String?
    
    
    
    init(user_id:Int,booking_date:String,booking_time:String,booking_cat:String,booking_area:String) {
        self.user_id = user_id
        self.booking_date = booking_date
        self.booking_time = booking_time
        self.booking_cat = booking_cat
        self.booking_area = booking_area
    }
    init(user_id:Int) {
        self.user_id = user_id
    }
    
}
