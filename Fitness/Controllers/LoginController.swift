//
//  LoginController.swift
//  Fitness
//
//  Created by Namrata Akash on 18/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
@objc protocol userloginDelegte
{
    @objc optional func userlog_returnresp(ajsondata:[Any])
 @objc func getUserID_returnResp(ajsondata:[Any])
}

class LoginController: NSObject {
var delegate:userloginDelegte?
    
    
func userlogin(amodel:userloginModel)
  {
    let url = URL(string: "\(Constant.commom_base_url)userLogin.php?email=\(amodel.user_email!)&password=\(amodel.user_password!)")
    if(url != nil)
    
{
        Commoncall().WScallforRequest(nURL: url!) { (resp) in
            self.delegate?.userlog_returnresp!(ajsondata: resp)
            print("delegate method called")
        }
    }
        else
        {
            print("something went wrong")
        }
    
    }
    func getUserID(aLoginModelObj :userloginModel)
    {
        let aUrlObj = URL(string:"http://localhost/Fitness/getUserID.php?name=\(String(describing: aLoginModelObj.name!))&email=\(aLoginModelObj.user_email!)");
           print(aUrlObj!);
           
           if(aUrlObj != nil)
           {
            Commoncall().WScallforRequest(nURL: aUrlObj!, completion: { (result) -> () in
                   print("Delegate method called..");
                self.delegate?.getUserID_returnResp(ajsondata: result);
                });
           }
           else
           {
               print("LOG = Something went wrong...");
           }
    }
    }
    


