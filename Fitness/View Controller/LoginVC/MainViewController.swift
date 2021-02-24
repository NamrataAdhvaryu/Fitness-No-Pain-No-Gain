//
//  MainViewController.swift
//  Fitness
//
//  Created by Namrata Akash on 01/09/20.
//  Copyright © 2020 namrata. All rights reserved.
//

import UIKit
import FCAlertView
import GoogleSignIn

class MainViewController: UIViewController,FCAlertViewDelegate,UITextFieldDelegate,userloginDelegte, userprofileDelegate{
    
    @IBOutlet weak var btnshow: UIButton!
    @IBOutlet weak var lblpassword: UILabel!
    @IBOutlet weak var logIn: GIDSignInButton!
    @IBOutlet weak var googleout: UIButton!
    @IBOutlet weak var facebookout: UIButton!
    @IBOutlet weak var txtmailid: UITextField!
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var mailimgview: UIView!
    @IBOutlet weak var lblmailid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        googleout.layer.cornerRadius = 20
//        googleout.clipsToBounds = true
        facebookout.layer.cornerRadius = 20
        facebookout.clipsToBounds = true
//        logIn.buttonUI(acircleradius: 10.0)
        mailimgview.viewUI(acircleradius: 10)
        self.tabBarController?.tabBar.isHidden  = true;
        
        if commomcodeobj.checkplistfileexistornot(afinalpath: commomcodeobj.getPath(aStrPlistNameRef: Constant().USER_LOGIN_PLIST))
        {
                    commomcodeobj.pushVCwithoutanimate(acurrentvc: self, nextvcidentifier: "tapbaridentifier")
                }
    }
    func GoogleSignIn()
    {
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

    func userlog_returnresp(ajsondata: [Any]) {
        print(ajsondata)
        if ajsondata.count == 1
        {
            let dic = ajsondata[0] as! [String:Any]
            Commoncode().createplist(aStrPlistNameRef: Constant().USER_LOGIN_PLIST, dic: dic)
            Commoncode().pushVC(acurrentvc: self, nextvcindentifier: "tapbaridentifier")

        }
        else{
            self.alertviewperform(ainview: self, awithTitle: "Alert", awithsubtitle: "invalid email or password", awithCustomImage: UIImage(named: "alert")!, awithDoneButtonTitle: "Ok", aandButtons: nil )
        }
    }
  
    func CallWSToUpdateUserProfileData(aDictRef:[String:Any])
    {
        let aIntProfileId = Int(aDictRef["id"] as! String)!
        let aname = aDictRef["name"] as! String
        let aContrlObj = UserProfileController()
        aContrlObj.delegate = self;
        
        let aModelObj  = profilemodel(profile_id: aIntProfileId, name:aname , mail: txtmailid.text!)
        aContrlObj.insertUserProfile(amodel: aModelObj)
    }
    func callWSlogin()
    {
        let aloginobj = LoginController()
        aloginobj.delegate = self
        let amodelobj = userloginModel(user_email: txtmailid.text!, user_password: txtpass.text!)
        aloginobj.userlogin(amodel: amodelobj)
    }
    @IBAction func registerbuttonclick(_ sender: Any) {
        Commoncode().pushVC(acurrentvc: self, nextvcindentifier: "register")
    }

    @IBAction func loginbtnclick(_ sender: Any) {
        if (txtmailid.text != "") && (txtpass.text != "")
        {
            if Commoncode().isValidEmail(email: txtmailid.text!){
                if Commoncode().isValidPassword(pwd: txtpass.text!){
                    callWSlogin()
                    print("sucess")
              }else {
                  
                  lblpassword.text = "invalid password"
              }}else {
                  
                  lblmailid.text = "invalid mailid"
              }}else {
                  
                  print("invalid username")
              }
    }
    func alertviewperform(ainview : UIViewController,awithTitle:String,awithsubtitle:String,awithCustomImage:UIImage, awithDoneButtonTitle:String,aandButtons: [Any]?)  {
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
    
    @IBAction func Emailtextfileddidchange(_ sender: UITextField) {
        
        
        if Commoncode().isValidEmail(email: txtmailid.text!) {
            
            txtmailid.forcorrectfield()
            lblmailid.isHidden = true
        }
        else {
            
            txtmailid.forwrongfield()
            lblmailid.text = "Firstpart@secondPart.domainname"
        }
    }
    func getUserID_returnResp(ajsondata: [Any])
    {
        print(ajsondata);
  
        if ajsondata.count == 1
        {
            DispatchQueue.main.async
            {
                let aDictTemp = ajsondata[0] as? [String:Any];
                self.CallWSToUpdateUserProfileData(aDictRef: aDictTemp!);
            }
            print("LOG = Got data sucessfully ...");
        }
        else
        {
            print("LOG = Failed ...");
        }
    }
    func insertUserProfile_returnresp(aArrJsonResponse: [Any])
    {
        print("aArrJsonResponse:\(aArrJsonResponse)");
        let aDictTemp  = aArrJsonResponse[0] as? [String:String];
        let aStrStatus  = aDictTemp!["status"];
        
        if aStrStatus == "Success"
        {
             print("LOG = Record Inserted Sucessfully ...");
        }
        else
        {
            print("LOG = Failed ...");
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
 
    @IBAction func btnShowHide(_ sender: UIButton) {
        
        if btnshow.titleLabel?.text == "Show" {
            
            txtpass.isSecureTextEntry = false
            btnshow.setImage(UIImage(named: "if_eye_1545742.png"), for: .normal)
            btnshow.setTitle("Hide", for: .normal)
        }
        else {
 txtpass.isSecureTextEntry = true
            btnshow.setImage(UIImage(named: "if_icon-21-eye-hidden_314858.png"), for: .normal)
            btnshow.setTitle("Show", for: .normal)
        }
    }
    
    @IBAction func googleloginaction(_ sender: Any) {
        
        GoogleSignIn()
    }
}
