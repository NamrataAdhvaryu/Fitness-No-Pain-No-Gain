//
//  UserregistrationController.swift
//  Fitness
//
//  Created by Namrata Akash on 17/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit

@objc protocol UserregistrationDelegate
{
    @objc optional func usereg_returneresp(njsonresp:[Any])
    @objc optional func changepwd_returneresp(njsonresp:[Any])
}

class UserregistrationController: NSObject
{
    
    var delegate : UserregistrationDelegate?;
    func userregistration(amodel:userRegistrationModel)
    {
        let url = URL(string: "\(Constant.commom_base_url)userRegistration.php")
        var request = URLRequest(url: url!)
        var strbody = "name=\(amodel.user_name!)&email=\(amodel.user_email!)&password=\(amodel.user_password!)&mobnum=\(amodel.user_mobilenumber!)"
        if (url != nil)
        {
            Commoncall().WScallforpost(aurl: url!, arefstring: strbody) { (resp) in
                
                self.delegate?.usereg_returneresp!(njsonresp: resp)
                print("delegate mathod called.....")
            }
        }
        else
        {
            print("delegate mathod not called properly")
        }
    }
    func changepassword(amodel:userRegistrationModel)
    {
        let aurl = URL(string: "\(Constant.commom_base_url)changePassword.php")
        var request = URLRequest(url: aurl!)
        var astrbody = "id=\(amodel.id!)&password=\(amodel.user_password!)"
        if (aurl != nil)
        {
            Commoncall().WScallforpost(aurl: aurl!, arefstring: astrbody) { (resp) in
                self.delegate?.changepwd_returneresp!(njsonresp: resp)
                print("Delegate method called.....")
            }
        }
            else
            {
                print("Delegate method not called properly")
            }
        }
    }

