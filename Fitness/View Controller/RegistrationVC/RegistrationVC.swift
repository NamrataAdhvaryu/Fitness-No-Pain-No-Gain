//
//  RegistrationVC.swift
//  Fitness
//
//  Created by Namrata Akash on 02/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import FCAlertView

var commomcodeobj = Commoncode()
class RegistrationVC: UIViewController,FCAlertViewDelegate,UITextFieldDelegate, UserregistrationDelegate, userloginDelegte, userprofileDelegate {

    
    //outlets
    @IBOutlet weak var btnshowpwd: UIButton!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var lblconfirmpwd: UILabel!
    @IBOutlet weak var lblmobilenumber: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var imgvwsignup: UIView!
    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtmobile: UITextField!
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var txtconfirmpass: UITextField!
    @IBOutlet weak var btnregister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgvwsignup.viewUI(acircleradius: 10)
        btnregister.buttonUI(acircleradius: 10.0)
    }
    @IBAction func Registerbtnclick(_ sender: Any) {
        if txtemail.text != "" && txtusername.text != "" && txtpass.text != "" && txtemail.text != "" && txtconfirmpass.text != "" {
            if Commoncode().isvalidusername(ausername: txtusername.text!){
                
                if Commoncode().isValidEmail(email: txtemail.text!) {
                    
                    if Commoncode().isValidMobile(mobile: txtmobile.text!) {
                        
                        if Commoncode().isValidPassword(pwd: txtpass.text! ){
                            
                            if isValidvonfirmpwd(confirmpwd: txtconfirmpass.text!){
                                
                                CallWSRegistration()
                                
                                print("sucess")
                            }else {
                                
                                lblusername.text = "invalid username"
                            }
                        }else {
                            
                            lblemail.text = "invalid mailid"
                        }
                    }else {
                        
                        lblmobilenumber.text = "invalid mobile number"
                    }
                }else {
                    
                    lblpassword.text = "invalid password"
                }
            }else {
                
                lblconfirmpwd.text = "password not matching"
            }
        }
        else {
            
            print("Kindly enter fully detail")
        }
        
    }
 
    func alertviewperform(ainview : UIViewController,awithTitle:String,awithsubtitle:String,awithCustomImage:UIImage, awithDoneButtonTitle:String,aandButtons: [Any]?,aid:Int)  {
        let alert = FCAlertView()
        alert.delegate = self
        alert.showAlert(inView: self,
                        withTitle: awithTitle,
                        withSubtitle: awithsubtitle,
                        withCustomImage:awithCustomImage,
                        withDoneButtonTitle:awithDoneButtonTitle,
                        andButtons:nil)
        alert.cornerRadius = 10
        alert.colorScheme = UIColor.init(displayP3Red: 150, green: 150, blue: 150, alpha:0.0)
        alert.colorScheme = alert.flatBlue
        
    }
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        if (alertView.title == "Success")
        {
            commomcodeobj.pushVC(acurrentvc: self, nextvcindentifier: "loginidentifier")
        }
        else
        {
            print("try again")
        }
    }
    
    @IBAction func backbtnitem(_ sender: Any) {
        commomcodeobj.pushVCwithoutanimate(acurrentvc: self, nextvcidentifier: "loginidentifier")
    }
    func usereg_returneresp(njsonresp: [Any]) {
        print(njsonresp)
        let dic = njsonresp[0] as! [String:Any]
        let status = dic["status"] as! String
        if (status == "Success")
        {
            
            DispatchQueue.main.async {
                
                self.alertviewperform(ainview: self, awithTitle: "Success", awithsubtitle: "registration done", awithCustomImage:(UIImage(named: "smiley"))! , awithDoneButtonTitle: "OK", aandButtons: nil,aid: 101)
                print("record inserted sucessfully...")
                
            }
            
        }
        else
        {
            self.alertviewperform(ainview: self, awithTitle: "Fail", awithsubtitle: "Something went wrong", awithCustomImage:(UIImage(named: "sad"))! , awithDoneButtonTitle: "OK", aandButtons: nil,aid: 100)
        }    }
    func CallWSRegistration()
    {
        let aRegContrlObj = UserregistrationController();
        aRegContrlObj.delegate = self;
        let aModelObj  = userRegistrationModel(user_name: txtusername.text!, user_email: txtemail.text!, user_password: txtpass.text!, user_mobilenumber: txtmobile.text!)
        aRegContrlObj.userregistration(amodel: aModelObj)
    }
    func callWStogetuserID()
    {
        let ctrlobj = LoginController()
        ctrlobj.delegate = self
        let modelobj = userloginModel(name:txtusername.text! , user_email: txtemail.text!)
        ctrlobj.getUserID(aLoginModelObj: modelobj)
        
    }
    func  callWStoupdateuserprofiledata(adic:[String:Any])  {
        let intprofileid = Int(adic["id"] as! String)!
        let ctrl = UserProfileController()
        ctrl.delegate = self
        let amodel = profilemodel(profile_id: intprofileid, name: txtusername.text!, mail: txtemail.text!)
        ctrl.insertUserProfile(amodel: amodel)
        
        
    }
    func insertUserProfile_returnresp(arrresp: [Any])
    {
        print("arrresp:\(arrresp)")
        let dic = arrresp[0] as! [String:String]
        let astatus = dic["status"] as! String
        
        if (astatus == "Success")
        {
            print("record inserted sucessfully....")
        }
        else
        {
            print("something went wrong...")
        }
    }
    
    func getUserID_returnResp(ajsondata: [Any]) {
        print(ajsondata)
        if(ajsondata.count == 1 )
        {
            DispatchQueue.main.async {
                let dic = ajsondata[0] as! [String:Any]
                self.callWStoupdateuserprofiledata(adic:dic)
            }
            print("record inserted sucessfully.....")
        }
        else{
            print("something went wrong.. ")
        }
    }
    @IBAction func Usernamedidchange(_ sender: Any) {
        if Commoncode().isvalidusername(ausername: txtusername.text!)
        {
            txtusername.forcorrectfield()
            lblusername.isHidden = true
        }
        else
        {
            txtusername.forwrongfield()
            lblusername.isHidden = false
        }
    }
    
    
    @IBAction func Emailtextfileddidchange(_ sender: UITextField) {
        
        if Commoncode().isValidEmail(email: txtemail.text!) {
            
            txtemail.forcorrectfield()
            lblemail.isHidden = true
        }
        else {
            
            txtemail.forwrongfield()
            lblemail.isHidden = false
            lblemail.text = "Firstpart@secondPart.domainname"
        }
    }
    
    @IBAction func Confirmpwddidchange(_ sender: Any) {
        if isValidvonfirmpwd(confirmpwd: txtconfirmpass.text!)
        {
            txtconfirmpass.forcorrectfield()
            lblconfirmpwd.isHidden = true
        }
        else
        {
            txtconfirmpass.forwrongfield()
            lblconfirmpwd.isHidden = false
            lblconfirmpwd.text = "not matching"
        }
        
    }
    @IBAction func Mobiletextfielddidchange(_ sender: UITextField) {
        
        if Commoncode().isValidMobile(mobile: txtmobile.text!) {
            txtmobile.forcorrectfield()
            lblmobilenumber.isHidden = true
        }
        else {
            
            txtmobile.forwrongfield()
            lblmobilenumber.isHidden = false
            lblmobilenumber.text = "09726174054 or +919726174054"
        }
    }
    
    @IBAction func Passwordtextfielddidchange(_ sender: Any) {
        
        if Commoncode().isValidPassword(pwd: txtpass.text!) {
            
            txtpass.forcorrectfield()
            lblpassword.isHidden = true
        }
        else {
            
            txtpass.forwrongfield()
            lblpassword.isHidden = false
            lblpassword.text = "at least one capital,numeric or special character"
        }
    }

    func isValidvonfirmpwd(confirmpwd:String) -> Bool
    {
        if (txtpass.text == txtconfirmpass.text)
        {
            return true
        }
        return false
    }
    @IBAction func btnShowHide(_ sender: UIButton) {
        
        if btnshowpwd.titleLabel?.text == "Show" {
            
            txtpass.isSecureTextEntry = false
            btnshowpwd.setImage(UIImage(named: "if_eye_1545742.png"), for: .normal)
            btnshowpwd.setTitle("Hide", for: .normal)
        }
        else {
            txtpass.isSecureTextEntry = true
            btnshowpwd.setImage(UIImage(named: "if_icon-21-eye-hidden_314858.png"), for: .normal)
            btnshowpwd.setTitle("Show", for: .normal)
        }
    }
    
}
