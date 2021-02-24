//
//  BookingController.swift
//  Fitness
//
//  Created by Namrata Akash on 20/12/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
@objc protocol BookingDelegate
{
    @objc optional func booking_returnresp(ajsondata:[Any])
    @objc optional func updatebooking_returnresp(ajsondata:[Any])
}

class BookingController: NSObject {
    var delegate:BookingDelegate?
    
    func GetBookingdata(amodel:bookingmodel)
    {
        let aurl = URL(string:"\(Constant().BASE_URL)UserBooking.php?")
        var arequest = URLRequest(url: aurl!)
        var astrbody = "user_id=\(amodel.user_id!)&booking_date=\(amodel.booking_date!)&booking_time=\(amodel.booking_time!)&booking_cat=\(amodel.booking_cat!)&booking_area=\(amodel.booking_area!)"
        
        
        if(aurl != nil)
        {
            Commoncall().WScallforpost(aurl: aurl!, arefstring: astrbody) { (resp) in
                self.delegate?.booking_returnresp?(ajsondata: resp)
                print("Delegate method called.....")
            }
        }
        else
        {
            print("delegate method not called.....")
        }
    }
    func  Updatebookingdata(amodel:bookingmodel)  {
        let aurl = URL(string: "\(Constant().BASE_URL)UserViewBookingData.php?user_id=\(Commoncode().getCurrentuserID())")
        var arequest = URLRequest(url: aurl!)
        
        
        if (aurl != nil)
        {
            Commoncall().WScallforRequest(nURL: aurl!) { (resp) in
                self.delegate?.updatebooking_returnresp?(ajsondata: resp)
                print("delegate method called")
            }
        }
        else
        {
            print("delegate method not called....")
        }
    }

}
