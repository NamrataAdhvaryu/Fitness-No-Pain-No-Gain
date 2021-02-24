//
//  ChangePasswordVC.swift
//  Fitness
//
//  Created by Namrata Akash on 02/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import FCAlertView

class ChangePasswordVC: UIViewController, FCAlertViewDelegate,UserregistrationDelegate
{
 
    
    
    
    

    @IBOutlet weak var oldpasstxt: UITextField!
    @IBOutlet weak var confirmpasstxt: UITextField!
    @IBOutlet weak var newpasstxt: UITextField!
    @IBOutlet weak var imgviewcp: UIView!
    @IBOutlet weak var change: UIButton!
    
    var dicforprevdetailref = [String:String]()
    var dicforprevlogindetail = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        change.buttonUI(acircleradius: 10)
        imgviewcp.viewUI(acircleradius: 10)
    }
    
    @IBAction func changePWDbtn(_ sender: Any) {
        var astrprevpwd = ""
        if Commoncode().CheckPlistFileIsExistOrNotAsPerFileName(aStrPlistName: Constant().USER_LOGIN_PLIST) {
            dicforprevdetailref = Commoncode().readPlist(aStrPlistNameRef: Constant().USER_LOGIN_PLIST)
            astrprevpwd = dicforprevdetailref["password"] as! String
        }
        if (oldpasstxt.text == astrprevpwd)
        {
          
                callWStochangepassword()
            
        }
        else
        {
            alertviewperform(ainview: self, awithTitle: "Wrong!!", awithsubtitle: "Invalid Old Password", awithDoneButtonTitle: "OK", ainttag: 100)
        
    }
    }
    func callWStochangepassword()
    {
        let ctrlobj = UserregistrationController()
        ctrlobj.delegate = self
        let amodel = userRegistrationModel(user_id: Commoncode().getCurrentuserID(), user_password: newpasstxt.text!)
        ctrlobj.changepassword(amodel: amodel)
    }
    @IBAction func changepasswordbackbtn(_ sender: Any) {
        Commoncode().pushVCwithoutanimate(acurrentvc: self, nextvcidentifier: "MoreVC")
    }
    
    func changepwd_returneresp(njsonresp: [Any]) {
        print(njsonresp)
        if (njsonresp != nil)
        {
            let dic = njsonresp[0] as! [String:Any]
            let astatus = dic["status"] as! String
            if (astatus == "Success")
            {
                self.alertviewperform(ainview: self, awithTitle: "Sucess", awithsubtitle: "Data inserted Sucessfully", awithDoneButtonTitle: "ok", ainttag: 101)
                DispatchQueue.main.async { [self] in
                    
                    
                    let aid = dicforprevdetailref["id"]
                    let aname = dicforprevdetailref["name"]!
                    let aemail = dicforprevdetailref["email"]!
                    let apassword = newpasstxt.text
                    let amobnum = dicforprevdetailref["mobnum"]!
                    if (confirmpasstxt.text == apassword)
                    {
                    self.dicforprevlogindetail["id"] = aid
                    self.dicforprevlogindetail["name"] = aname
                    self.dicforprevlogindetail["email"] = aemail
                    self.dicforprevlogindetail["mobnum"] = amobnum
                    self.dicforprevlogindetail["password"] = apassword
                    
                    Commoncode().createplist(aStrPlistNameRef: Constant().USER_LOGIN_PLIST, dic: dicforprevlogindetail)
                }
                    else
                    {
                        alertviewperform(ainview: self, awithTitle: "Wrong!!", awithsubtitle: "Invalid Confirm Password", awithDoneButtonTitle: "OK", ainttag: 100)
                    }
                
            }
                
                
            }
            else
            {
                self.alertviewperform(ainview: self, awithTitle: "Error", awithsubtitle: "Somwrongetihing went ", awithDoneButtonTitle: "ok", ainttag: 101)
            }
        }
    }
    
    func alertviewperform(ainview : UIViewController,awithTitle:String,awithsubtitle:String, awithDoneButtonTitle:String,ainttag:Int)  {
        let alert = FCAlertView()
        
        
        alert.delegate = self
        
        alert.showAlert(withTitle: awithTitle, withSubtitle: awithsubtitle, withCustomImage: nil, withDoneButtonTitle: awithDoneButtonTitle, andButtons: nil)
        
        alert.cornerRadius = 10
        alert.colorScheme = UIColor.init(displayP3Red: 150, green: 150, blue: 150, alpha:0.0)
        alert.colorScheme = alert.flatBlue
        
    }

}

