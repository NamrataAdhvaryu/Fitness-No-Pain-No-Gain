//
//  UserProfileController.swift
//  Fitness
//
//  Created by Namrata Akash on 31/10/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

@objc protocol userprofileDelegate
{
    @objc optional func insertUserProfile_returnresp(arrresp: [Any])
    @objc optional func updateUserProfile_returnresp(arrresp:[Any])
    @objc optional func getUserData_returnesp(arrresp:[Any])
}

class UserProfileController: NSObject
{
    var delegate:userprofileDelegate?
    
    func insertUserProfile(amodel: profilemodel) {
        let url = URL(string: "http://localhost/Fitness/insertUserProfile.php")
        let strbody = "profile_id=\(amodel.profile_id!)&name=\(amodel.name!)&mail=\(amodel.mail!)"
        if (url != nil)
        {
            Commoncall().WScallforpost(aurl: url!, arefstring: strbody, completion: { (Result) -> () in
                print("delegate method called.....")
                self.delegate?.insertUserProfile_returnresp?(arrresp: Result)
            })
        }
        else
        {
            print("something went wrong")
        }
    }
    func updateUserProfile(amodel: profilemodel) {
        let url = URL(string: "http://localhost/Fitness/updateUserProfile.php")
        let strbody = "profile_id=\(amodel.profile_id!)&name=\(amodel.name!)&display_name=\(amodel.display_name!)&gender=\(amodel.gender!)&dob=\(amodel.dob!)&email=\(amodel.mail!)&mobile_no=\(amodel.mobile_no!)&area=\(amodel.area!)&city=\(amodel.city!)&country=\(amodel.country!)&about_us=\(amodel.about_us!)&batch_detail=\(amodel.batch_detail!)&user_profile_img=\(amodel.user_profile_img!)&user_cover_img=\(amodel.user_cover_img!)"
        
        
        
        
        
        if (url != nil)
  
        {
            Commoncall().WScallforpost(aurl: url!, arefstring: strbody, completion:{ (result) -> () in
                print("delegate method called")
                self.delegate?.updateUserProfile_returnresp?(arrresp: result)
            })
        }
        else
        {
            print("something went wrong")
        }
    }
    func getUserProfile(amodel: profilemodel) {
        
        
        let url = URL(string: "http://localhost/Fitness/getProfile.php?profile_id=\(amodel.profile_id!)")
        
        if (url != nil)
        {
            Commoncall().WScallforRequest(nURL: url!) { (result) in
                print("delegate method called")
                self.delegate?.getUserData_returnesp?(arrresp: result)
            }
            
        }
        else {
            print("something went wrong")
        }
        
    }
    
    
    
}

